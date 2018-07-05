---
title: Development Overview
keywords: development guide api
tags: [development]
sidebar: overview_sidebar
permalink: development_overview.html
summary: "Overview for developers on how to integrate with the Prescription Exemption Checking Service"
---

## Development Overview ##


### Requests ###
All requests are HTTP POSTs of a json object with the following properties:

| Property		|	Description															|	Data type		| Example												|		
+-------------+-----------------------------------------+-------------+-------------------------------|
|	`dob`				|	**Date of Birth** of the patient				|	Date				| 2010-01-01										|
|	`nhsNumber`	| **NHS Number** which must be traced and verified with Spine Demographics | String	| 9434765919 |
|	`postcode`	|	**Post Code** of patient's usual address	|	String			|	NE32JH													|
|	`surname`|	**Family Name** from patient's usual name	|	String			|	Parker													|

### Response ###
The json response will contain a simple object with the following properties. Note that these properties are not ordered so may appear in any order.

| Property	|	Description															|	Data type					| Example													|		
+-----------+-----------------------------------------+-------------------+---------------------------------|
|	`expiry`	|	**Expiry date of the exemption** until which the response can be cached	|	Date	| 2019-01-01	|
|	`message`	| **Exemption description or error** which can be displayed to the user		| String	| gets income support (IS) - confirmed by source |
|	`type`		|	**Exemption type** which should be returned in the reimbursement claim for EPS R2 prescriptions	|	String	|	9014	|


### Error Handling ###
The Prescription Exemption Checking Service API uses standard HTTP response codes with further details where available provided in the `message` property.

### Security ###

Security of the service follows established mechanisms for synchronous queries to Spine.

#### User Authentication & Authorization ####
Systems are required to be implement Role-Based Access Control using the Spine Security Broker. The details of the user and organisation are included in an OAuth Bearer Token carried in HTTP headers.

#### Endpoint Authentication ####
Systems are required to be registered Spine endpoints and will need to register the interaction ID for their accredited system. They will have a certificate issued and communications are secured via TLS mutual authentication. Thus only authorised external systems will have access to this service.

This will be enforced by checking that:

* the certificate used to connect to the service is current and valid.
* the Accredited System ID (ASID) of the sender matches that of the certificate.
* the ASID of the sender is included in the list of allowed ASIDs for this interaction.
