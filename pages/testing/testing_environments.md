---
title: Test Environments
keywords: test environments
tags: [testing,deployment]
sidebar: overview_sidebar
permalink: testing_environments.html
summary: "Details of what environments are available to support the technical accreditation and solution assurance process"
---

## Path to Live ##

The prescription exemption checking service utilises the following "Path to Live" environments. As the service is cloud hosted IP addresses may change and so are not provided.

### Spine Integration (INT) / NHSBSA Staging ###

To support the technical accreditation of integrating systems.

| Host                                        | Port  | Endpoint                          |
| --------------------------------------------| ----- | --------------------------------- |
| stg.nhsdapi.assured.nhsbsa.nhs.uk           | 443   | /rtec-api-gateway/search   |

### Mock ###

To support the initial development.

| Host                                        | Port  | Endpoint                          |
| --------------------------------------------| ----- | --------------------------------- |
| rtec-mock.eps.digital.nhs.uk                | 443   | /rtec-api-gateway/search   |

### Production (LIVE) ###

To support production use of the service.

| Host                                        | Port  | Endpoint                          |
| --------------------------------------------| ----- | --------------------------------- |
| TBC                                         | 443   | /rtec-api-gateway/search   |
