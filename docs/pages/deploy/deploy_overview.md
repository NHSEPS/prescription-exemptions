---
title: API Deployment Overview
keywords: deployment
tags: [testing,integration,deployment]
sidebar: overview_sidebar
permalink: deploy_overview.html
summary: An overview of how the API is deployed, and how to connect to it
---

## API Deployment and Usage

This page will cover the environments that the API is available in including the the network configuration. It will also cover how releases are deployed into these environments.

### Test Environments ###
There are a number of test environments available for general use in order to allow API and application testing:

  * **Live** - The production environment only by assured prescribing systems
  * **UAT** - Used in non functional testing of both API and applications

Other environments created to support specific testing may be used but may only be available over a fixed time period.

### Environment Details ###

This section provides details of the generally available environments. Other environments created to support specific testing may be used.

#### Live ####

| **DNS Name**    | eps-dos.service.nhs.uk    |
| **Virtual IP**  | 51.141.43.22              |
| **Port**        | TCP 443                   |
| **Dataset**     | Live                      |


#### UAT ####

User Acceptance Test. Infrastructure should directly reflect live, although may be scaled. Dataset should be the same as the live environment. The UAT environment may not be available outside of formal test windows.

| **DNS Name**    | test-eps-dos.service.nhs.uk |
| **Virtual IP**  | 51.141.38.68              |
| **Port**        | TCP 443                   |
| **Dataset**     | Live                      |
