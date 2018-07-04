---
title: System Authentication
keywords: development guide api sds certificate
tags: [development]
sidebar: overview_sidebar
permalink: system_auth.html
summary: "Description of system authentication by the API gateway "
---


Connecting systems are authenticated using TLS Mutual Authentication (MA), so systems must connect using the certificate issued for the purpose, and will need to have the appropriate CA certificates installed in their CA store so that they can complete the connection and identify the remote system.

## Service Authentication ##
On requesting an operation on the Prescription Exemption Checking Service the API gateway will:

- Validate the client certificate to ensure it includes valid certificate `CN` and `DN` details and that the certificate has not been added to the certificate revocation list (CRL).
- Ensure that the FQDN of the system making the request matches that of the ASID in the request
- Ensure that the requesting endpoint is permitted to use the requested operation by checking that the ASID includes an entry for the requested InteractionID

Requests not passing these check will receive a 401 response.

### Directory Entry ###

Connecting systems are required to be registered on Spine Directory Service consistently with existing prescriptions messaging. There are three key LDAP classes for a system to be able to use the service:

#### Accredited system - *nhsAS* ####

#### Message handler - *nhsMHS* ####

#### Interaction - *nhsSvcIA* ####
