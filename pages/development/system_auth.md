---
title: System Authentication
keywords: development guide api sds certificate
tags: [development]
sidebar: overview_sidebar
permalink: system_auth.html
summary: "Description of system authentication by the API gateway "
---


Connecting systems are not authenticated, but should include their Spine ASID in the Ssp-From request header. Systems must validate the certificate used by the service and so will need to have the appropriate CA certificates installed in their CA store so that they can complete the connection and identify the remote system.
