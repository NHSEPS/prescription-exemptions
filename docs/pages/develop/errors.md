---
title: Errors
keywords: develop
tags: [develop]
sidebar: overview_sidebar
permalink: errors.html
summary: Error reporting including the complete errorbase
---


Errors are generally using the HTTP status code with additional information available returned in the Error object. Where the error relates to a specific parameter
these are specifically named in the `fields` property. The Error object has the following definition:
```yaml
  Error:
    type: object
    properties:
      code:
        type: integer
        format: int32
      message:
        type: string
      fields:
        type: string
```
Example:
```json
{
  "code": 5,
  "message": "Invalid parameter",
  "fields": "ods:FLM23"
}

```
## Errorbase ##

All DoS-specific errors are listed below. This list is expected to be extended as the API is developed further. Normal HTTP-layer errors may also be returned.

| Code	| Message	| Fields	| HTTP Status	| Cause |
|-------|---------|---------|-------------|-------|
| 3     | Exceeded rate limit     | | 429	| When the call limit to the DoS API has been exceeded.     |
| 4	    | Invalid parameter | EPS API parameter value. | 400	| Thrown by this API if a parameter for a service is not given or it is invalid. The name of the missing or invalid parameter will be provided. |
| 6	    | This account is not authorised to use this method. | | 403 | A user account has not been authorised to call the DoS services required by this API. |
| 8	    | Dispenser search service not responding. | | 500	| When a call to a DoS service made by this API times out. |
| 10	  | Dispenser search service returned error: <Error from DoS API> | | 500	| An error is returned from the DoS API service which is called from this API. The error message from the DoS API will be displayed as part of this message. |
| 11	 | Authentication is required to access this resource. | | 403	| This is error is returned when a request with no authentication is provided. |
| 12	 | Authentication invalid. | | 403	| The authentication method is not valid for this API. The EPS API uses Basic Authentication. |
| 13	 | Service is down for maintenance. | | 503	| This is given when either the DoS API or the ETP API services are down for maintenance reasons. |
| 15	 | No matching dispenser found for the criteria specified. | | 500 |	This is given when no matching dispensers are found for the parameters values supplied. It means that all of the parameters given have been accepted and the DoS and ETP APIs have been successfully called, but the actual combination of the parameter values yields no result. |
| 16   | Bad Request: <Error message from DoS API> | DoS API parameter value.	| 400	 | When the DoS API rejects a call from this API as a result of a badly formatted or missing parameter that is required. The name of the parameter that is missing or invalid is provided in the message. |
| 20    | General Exception from EPS DoS API while processing request: <Internal error message> | |
500	| When an unexpected error is raised during the processing of a request. The error message invoking this error will be provided in the message. |

### Examples ###

```json
$ curl -u 'epsexample:3xample' 'https://eps-dos.service.nhs.uk/epsdispenser/byLocationAndTime?postcode=N1C+4AL&timeframe=2.9'
{
  "code": 4,
  "message": "Invalid parameter",
  "fields": "timeframe : 2.9"
}
```
