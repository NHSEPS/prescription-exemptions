---
title: Cross organisation audit and provenance
keywords: spine, ssp, integration, audit, provenance
tags: [integration]
sidebar: overview_sidebar
permalink: integration_cross_organisation_audit_and_provenance.html
summary: "Overview of how audit and provenance data is passed to the Prescription Exemption Checking Service."
---

## Cross organisation audit and provenance transport ##

### Bearer token ###

Connecting systems SHALL provide audit and provenance details in the HTTP authorisation header as an OAuth Bearer Token (as outlined in [RFC 6749](https://tools.ietf.org/html/rfc6749){:target="_blank"}) in the form of a JSON Web Token (JWT) as defined in [RFC 7519](https://tools.ietf.org/html/rfc7519){:target="_blank"}.

An example such an HTTP header is given below:

```
     Authorization: Bearer jwt_token_string
```

API gateway SHALL respond to OAuth Bearer Token errors in accordance with [RFC 6750 - section 3.1](https://tools.ietf.org/html/rfc6750#section-3.1).

It is highly recommended that standard libraries are used for creating the JWT as constructing and encoding the token manually may lead to issues with parsing the token. A good source of information about JWT and libraries to use can be found on the [JWT.io site](https://jwt.io/).


### JWT generation ###

Consumer system SHALL generate a new JWT for each API request. The consumer generated JWT SHALL consist of three parts separated by dots `.`, which are:

- header
- payload
- signature

#### Header ####
Requesting systems SHALL generate an unsecured JWT using the 'none' algorithm parameter in the header to indicate that no digital signature or MAC has been performed (please refer to section 6 of [RFC 7519](https://tools.ietf.org/html/rfc7519){:target="_blank"} for details).

```json
{
  "alg": "none",
  "typ": "JWT"
}
```

#### Payload ####

Requesting systems SHALL generate a JWT payload conforming to the requirements set out in the [JWT Payload](#jwt-payload) section of this page.

#### Signature ####

Requesting systems SHALL generate an empty signature.

#### Complete JWT ####

The final output is three Base64url encoded strings separated by dots (note - there is some canonicalisation done to the JSON before it is Base64url encoded, which the JWT code libraries will do for you).

```shell
eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwOi8vZWMyLTU0LTE5NC0xMDktMTg0LmV1LXdlc3QtMS5jb21wdXRlLmFtYXpvbmF3cy5jb20vIy9zZWFyY2giLCJzdWIiOiIxIiwiYXVkIjoiaHR0cHM6Ly9hdXRob3JpemUuZmhpci5uaHMubmV0L3Rva2VuIiwiZXhwIjoxNDgxMjUyMjc1LCJpYXQiOjE0ODA5NTIyNzUsInJlYXNvbl9mb3JfcmVxdWVzdCI6ImRpcmVjdGNhcmUiLCJyZXF1ZXN0ZWRfcmVjb3JkIjp7InJlc291cmNlVHlwZSI6IlBhdGllbnQiLCJpZGVudGlmaWVyIjpbeyJzeXN0ZW0iOiJodHRwOi8vZmhpci5uaHMubmV0L0lkL25ocy1udW1iZXIiLCJ2YWx1ZSI6IjkwMDAwMDAwMzMifV19LCJyZXF1ZXN0ZWRfc2NvcGUiOiJwYXRpZW50LyoucmVhZCIsInJlcXVlc3RpbmdfZGV2aWNlIjp7InJlc291cmNlVHlwZSI6IkRldmljZSIsImlkIjoiMSIsImlkZW50aWZpZXIiOlt7InN5c3RlbSI6IldlYiBJbnRlcmZhY2UiLCJ2YWx1ZSI6IkdQIENvbm5lY3QgRGVtb25zdHJhdG9yIn1dLCJtb2RlbCI6IkRlbW9uc3RyYXRvciIsInZlcnNpb24iOiIxLjAifSwicmVxdWVzdGluZ19vcmdhbml6YXRpb24iOnsicmVzb3VyY2VUeXBlIjoiT3JnYW5pemF0aW9uIiwiaWQiOiIxIiwiaWRlbnRpZmllciI6W3sic3lzdGVtIjoiaHR0cDovL2ZoaXIubmhzLm5ldC9JZC9vZHMtb3JnYW5pemF0aW9uLWNvZGUiLCJ2YWx1ZSI6IltPRFNDb2RlXSJ9XSwibmFtZSI6IkdQIENvbm5lY3QgRGVtb25zdHJhdG9yIn0sInJlcXVlc3RpbmdfcHJhY3RpdGlvbmVyIjp7InJlc291cmNlVHlwZSI6IlByYWN0aXRpb25lciIsImlkIjoiMSIsImlkZW50aWZpZXIiOlt7InN5c3RlbSI6Imh0dHA6Ly9maGlyLm5ocy5uZXQvc2RzLXVzZXItaWQiLCJ2YWx1ZSI6IkcxMzU3OTEzNSJ9LHsic3lzdGVtIjoibG9jYWxTeXN0ZW0iLCJ2YWx1ZSI6IjEifV0sIm5hbWUiOnsiZmFtaWx5IjpbIkRlbW9uc3RyYXRvciJdLCJnaXZlbiI6WyJHUENvbm5lY3QiXSwicHJlZml4IjpbIk1yIl19fX0.
```

**Note:**

- the final section (the signature) is empty, so the JWT will end with a trailing `.` (this must not be omitted, otherwise it would be an invalid token)


### JWT payload ###

The payload section of the JWT shall be populated as follows:

| Claim | Priority | Description | Fixed Value | Dynamic Value |
|-------|----------|-------------|-------------|------------------|
| iss | R | Requesting system ASID | No | Accredited System ID |
| sub | R | SDS user ID ID for the user on whose behalf this request is being made. Matches `requesting_practitioner` | No | Yes |
| aud | R | Requested resource URI | `http://[spine_proxy_url]/http://[pecs_service_url]/Prescription-Exemption/1.0.0/search` | No |
| exp | R | Expiration time integer after which this authorisation MUST be considered invalid. | No | (now() + 5 minutes) UTC time in seconds |
| iat | R | The UTC time the JWT was created by the requesting system | No | now() UTC time in seconds |
| reason_for_request | R | Purpose for which access is being requested | `directcare` | No |
| requested_scope | R | Data being requested | `Prescription-Exemption/1.0.0/search` | No |
| requesting_device | R | Device details and/or system url making the request | No | Accredited System ID |
| requesting_organization | R | ODS code for the organisation making the request | No | ODS code |
| requesting_practitioner | R | SDS user ID for the user making the request | No | SDS user ID |

#### Population of requesting_organization ####

The requesting system SHALL populate the `requesting_organization` claim with the ODS code for the organisation making the request, for example `FML84`.  This ODS code must identify the requesting organisation rather than site, multiple pharmacy HQ or software manufacturer.

{% include important.html content="Where locum pharmacists use RBAC roles registered with the national locum organisation 'FFFFF' it is important to ensure that the current organisation ID is included in the JWT, rather than the locum organisation." %}

#### Population of requesting_device ####

This claim is used to provide details of the originator of the request for auditing purposes.

Where the request originates from a system, the Spine endpoint URL of the originating system shall be specified using the URL element.

#### Population of ISS claim ####

As the requesting system is presently responsible for generating the access token, this SHALL contain the Accredited System ID of the requesting system.

In a future OAuth2 implementation, the ISS claim will contain the URL of the OAuth2 authorisation server token endpoint.


### JWT payload example ###

```json
{
  "iss": "200000010371",
  "sub": "313175813564",
  "aud": "https://proxy.int.spine2.ncrs.nhs.uk/https://apps.nhsbsa.nhs.uk/Prescription-Exemption/1.0.0/search",
  "exp": 1469436987,
  "iat": 1469436687,
  "reason_for_request": "directcare",
  "requested_scope": "Prescription-Exemption/1.0.0/search",
  "requesting_device": "200000010371"
  "requesting_organization": "FML84",
  "requesting_practitioner": "313175813564"
}
```

{% include important.html content="Whilst the use of a JWT and the claims naming is inspired by the [SMART on FHIR](https://github.com/smart-on-fhir/smart-on-fhir.github.io/wiki/cross-organizational-auth) NHS Digital hasn't committed to using the SMART on FHIR specification." %}

## Example code ##

### C# ###

{% include tip.html content="The following code snippet utilises the [Microsoft Identity Model JWT Token NuGet Package](https://www.nuget.org/packages/System.IdentityModel.Tokens.Jwt/) for creating, serializing and validating JWT tokens." %}

```C#
TODO

```
