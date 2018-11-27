---
title: Error Handling
keywords: development deliverables
tags: [development]
sidebar: overview_sidebar
permalink: errors.html
summary: "Description of how service errors are represented"
---


## Error Handling ##

In most cases an error response will result in the user opting to follow the normal paper process, so errors MUST not block user action or be reported in an intrusive way.

### HTTP Status ###
The Prescription Exemption Checking Service API uses standard HTTP response codes to indicate success.

| Status Code   | Outcome                           |
|:-------------:|-----------------------------------|
| 200           | Exemption has been found          |
| 400           | Bad request                       |
| 401           | Unauthorised                      |
| 404           | Exemption has not been found      |
| 500           | Unexpected error happened         |
| 501           | Not implemented
| 503           | Service unavailable               |

### Error Messages ###
Further detail of the error is reported in the `message` property in several cases.

| Status Code   | Message                           | Example                         |
|:-------------:|-----------------------------------|---------------------------------|
| 200           | Exemption has been found         | `{"message":"Exemption has been found","type":"9006"}` |
| 400           | Please provide a valid request or Please provide a valid {field list} | `{"message": "Please provide a valid postcode","type":null}`|
| 401           | *No response object returned*     |                                 |
| 404           | Exemption has not been found      | `{"message": "Exemption has not been found","type":null,"expiry":null}`|
| 500           | *No response object returned*     |                                 |
| 501           | *No response object returned*     |                                 |
| 503           | *No response object returned*     |                                 |

A complete errorbase will be provided in a later release.
