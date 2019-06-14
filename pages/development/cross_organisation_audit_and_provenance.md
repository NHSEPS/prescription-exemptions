---
title: Cross organisation audit and provenance
keywords: spine, integration, audit, provenance
tags: [integration]
sidebar: overview_sidebar
permalink: cross_organisation_audit_and_provenance.html
summary: "Overview of how audit and provenance data is passed to the Real Time Exemption Checking Service."
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
eyJ0eXAiOiJKV1QiLCJhbGciOiJub25lIn0.eyJzdWIiOiI1MDQzMDk3MzEwMTciLCJhdWQiOiJodHRwczovL3N0Zy5uaHNkYXBpLmFzc3VyZWQubmhzYnNhLm5ocy51ay9ydGVjLWFwaS1nYXRld2F5L3YxLjAuMC9zZWFyY2giLCJyZXF1ZXN0aW5nX2RldmljZSI6IjIwMDAwMDAwMDk0NiIsInJlcXVlc3RpbmdfcHJhY3RpdGlvbmVyIjoiNTA0MzA5NzMxMDE3IiwicmVxdWVzdGluZ19vcmdhbml6YXRpb24iOiJBMUIyQyIsImlzcyI6IjIwMDAwMDAwMDk0NiIsImV4cCI6MTU0Mjk5NTk5MSwiaWF0IjoxNTQyOTk1NjkxLCJyZWFzb25fZm9yX3JlcXVlc3QiOiJkaXJlY3RjYXJlIiwicmVxdWVzdGVkX3Njb3BlIjoiL3J0ZWMtYXBpLWdhdGV3YXkvdjEuMC4wL3NlYXJjaCJ9.
```

**Note:**

- the final section (the signature) is empty, so the JWT will end with a trailing `.` (this must not be omitted, otherwise it would be an invalid token)


### JWT payload ###

The payload section of the JWT shall be populated as follows:

| Claim | Priority | Description | Fixed Value | Dynamic Value |
|-------|----------|-------------|-------------|------------------|
| iss | R | Requesting system ASID | No | Accredited System ID |
| sub | R | SDS user ID ID for the user on whose behalf this request is being made. Matches `requesting_practitioner` | No | Yes |
| aud | R | Requested resource URI | `http://[pecs_service_host]/rtec-api-gateway/1.0.0/search` | No |
| exp | R | Expiration time integer after which this authorisation MUST be considered invalid. | No | (now() + 5 minutes) UTC time in seconds |
| iat | R | The UTC time the JWT was created by the requesting system | No | now() UTC time in seconds |
| reason_for_request | R | Purpose for which access is being requested | `directcare` | No |
| requested_scope | R | Data being requested | `/rtec-api-gateway/1.0.0/search` | No |
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
  "aud": "https://apps.nhsbsa.nhs.uk/Prescription-Exemption/1.0.0/search",
  "exp": 1469436987,
  "iat": 1469436687,
  "reason_for_request": "directcare",
  "requested_scope": "Prescription-Exemption/1.0.0/search",
  "requesting_device": "200000010371"
  "requesting_organization": "FML84",
  "requesting_practitioner": "313175813564"
}
```

## Example code ##

### Java ###

```Java
  private String jwtForOds(String ods) {
		try {
			return com.auth0.jwt.JWT.create()
			        .withClaim("iss", FROM_ASID)
			        .withClaim("sub", USER_ID)
			        .withClaim("aud", ENDPOINT_URL)
			        .withClaim("iat", new Date())
			        .withClaim("exp", Date.from(Instant.now().plus(5, ChronoUnit.MINUTES)))
			        .withClaim("reason_for_request", "directcare")
			        .withClaim("requested_scope", new URL(ENDPOINT_URL).getPath())
			        .withClaim("requesting_device", FROM_ASID)
			        .withClaim(ODS_CODE_CLAIM, ods)
			        .withClaim("requesting_practitioner", USER_ID)
			        .sign(Algorithm.none());
		} catch (Exception e) {
			return null;
		}
	}

```
