---
title: Development Overview
keywords: development guide api
tags: [development]
sidebar: overview_sidebar
permalink: development_overview.html
summary: "Overview for developers on how to integrate with the Real Time Exemption Checking Service"
---

## Development Overview ##

### Functional & Non Functional Requirements ###

Integrating systems must meet the client requirements listed below:

* [Real Time Exemption Checking Service - Client Functional Requirements](downloads/development/Real Time Exemption Checking Service - Client Functional Requirements v1.0.pdf)

* [Real Time Exemption Checking Service - Client Non Functional Requirements](downloads/development/Prescription Exemption Checking Service - Client Non Functional Requirements_v0.1.pdf)

### Requests ###
All requests are HTTP POSTs of a json object with the following properties:

| Property		|	Description															|	Data type		| Example												|		
+-------------+-----------------------------------------+-------------+-------------------------------|
|	`dob`				|	**Date of Birth** of the patient				|	Date				| 2010-01-01										|
|	`nhsNumber`	| **NHS Number** which must be traced and verified with Spine Demographics | String	| 9434765919 |
|	`postcode`	|	**Post Code** of patient's usual address	|	String			|	NE32JH													|
|	`surname`|	**Family Name** from patient's usual name	|	String			|	Parker													|
|`prescriptionId` | EPS R2 **Prescription ID** from the prescription | String | 471BC8-P83027-34B75X

### Response ###
The json response will contain a simple object with the following properties. Note that these properties are not ordered so may appear in any order.

| Property	|	Description															|	Data type					| Example													|		
+-----------+-----------------------------------------+-------------------+---------------------------------|
|	`message`	| **Exemption description or error** which can be displayed to the user		| String	| `Exemption has been found` |
|	`type`		|	**Exemption type** which should be returned in the reimbursement claim for EPS R2 prescriptions	|	String	|	`9005`	|


### Error Handling ###
The Prescription Exemption Checking Service API uses standard HTTP response codes with further details where available provided in the `message` property.

### Security ###

#### User Authentication & Authorization ####
Systems are required to be implement Role-Based Access Control using the Spine Security Broker. The details of the user and organisation are included in an OAuth Bearer Token carried in HTTP headers.

#### Endpoint Authentication ####
No client authentication is required, and systems are not required to use a client certificate when connecting to the service. Clients must install the root and intermediary Certificate Authorities used by the service, and must validate the server certificate used by the service, ensuring that it matches the hostname of the service. Systems should be registered Spine endpoints in order to provide their ASID in the request header.
