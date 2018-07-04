---
title: User Authentication & Authorization
keywords: development guide api
tags: [development]
sidebar: overview_sidebar
permalink: user_auth.html
summary: "Description of user authentication and authorization by connecting systems "
---

## User Authentication & Authorization ##

Connecting systems are responsible for ensuring users are authenticated and authorized before carrying out prescription exemption checks, and including user details in calls to the service.

### Authentication ###
All calls to the Prescription Exemption Checking Service must be made by a user authenticated by Spine, as described by Spine External Integration Specification Part 7.

### Authorization ###
Systems must ensure that users carrying out prescription exemption checks have the *B0570 - Perform Pharmacy Activities* activity on their selected Spine user profile. The activity *B0572 -  Manage Pharmacy Activities* is expected to be required for reimbursement activities which will include sending EPS claim messages including prescription exemption check outcomes.

Clients must implement RBAC as defined in the National RBAC Database (NRD), and in order to map the correct activities to roles implementation must include at least the pharmacy-related roles. At version 27.2 of the NRD the following baseline roles are included in the EPS Pharmacy restriction set:

| Job Role Code | Job Role description      | Included Activities - Pharmacy Area of Work |
|-------|-------------------------------------|---------------|
| R8008	| Admin/Clinical Support Access Role  | B0572         |
| R8004	| Healthcare Student Access Role      | B0570         |
| R8003	| Health Professional Access Role     | B0068, B0572  |
| R1290	| Pharmacist                          | -             |

Authorized activities are included in the Job Role or can be explicitly added to the User Role Profile by the Registration Authority (RA). Only activities added additionally to the Job Role are included in the SAML response from SSB.

## Passing User Details to the Prescription Exemption Checking Service ##

Although the Prescription Exemption Checking Service does not perform any user auth, details of the authenticated user must be included in calls to the Service in the HTTP authorisation header as per [Cross Organisation Audit and Provenance](cross_organisation_audit_and_provenance.html).
