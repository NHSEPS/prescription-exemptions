---
title: API Operations Listing
keywords: development deliverables
tags: [development]
sidebar: overview_sidebar
permalink: api_operations.html
summary: "Listing of operations the Prescription Exemption Checking Service exposes for connecting systems to call"
---
The Prescription Exemption Checking Service exposes a single search operation to connecting systems. InteractionID which must be registered on Spine Directory Service for the Accredited System and MHS using the service is detailed below.

## Interactions ##

All InteractionIDs are expected to follow the following format `urn:nhs:names:services:[program]:[standard]:[mechanism]:[operation]:[subject]`. As such for the Prescription Exemption Checking Service the following InteractionID is used:

- Program = `prescription-exemptions`
- Standard = `custom`
- Mechanism = `operation`
- Operation = `search`
- Subject = `prescription-exemptions`

| Operation	| InteractionID	| HTTP verb	| Example URL pattern |
|-----------|---------------|-----------|---------------------|
| [search](api_operations_reference.html#operation/searchUsingPOST)    | `urn:nhs:names:services:prescription-exemptions:custom:operation:search:prescription-exemptions` | `POST` | `[base]/v1.0.0/search​` |
