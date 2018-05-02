---
title: Integrating with Prescription Messaging
keywords: develop
tags: [develop]
sidebar: overview_sidebar
permalink: integrating_messaging.html
summary: How to integrate information from the EPS DoS API with Prescription messaging
---


Once a suitable dispenser has been identified using the Search resources this information needs to be included in the prescription message if. There are two relevant parts of the message: the nominated dispenser and the nominated dispenser type.

## Nominated Dispenser Type
As described in [Key Concepts](key_concepts.html), there are different types of dispensing contractor, with some not able to dispense all items and some not directly accessible by the patient; as such it is important to nominate the correct type of dispenser and cross-check against the prescribed item classification where appropriate.

The dispenser type is available within the EPS DoS API as the _service_type_ property. The vocabulary used to identify the dispenser type in the messafge is defined in the Message Specification. A cross-map to values in the _DispensingSitePreference_ vocabulary in MIM 4.2.02 is provided below:

| EPS DoS API Service Type | Dispensing Site Preference code |
|--------------------------|---------------------------------|
| eps_pharmacy             | P1                              |

Dispensier type is included in all prescription messages, including those with no nomination. It is held at the xpath `ParentPrescription/pertinentInformation1/pertinentPrescription/pertinentInformation1/pertinentDispensingSitePreference/value/@code`

```xml
<pertinentInformation1 contextConductionInd="true" typeCode="PERT">
  <seperatableInd value="true"/>
  <pertinentDispensingSitePreference classCode="OBS" moodCode="EVN">
    <code code="DSP" codeSystem="2.16.840.1.113883.2.1.3.2.4.17.30"/>
    <value code="P1" codeSystem="2.16.840.1.113883.2.1.3.2.4.17.21"/>
  </pertinentDispensingSitePreference>
</pertinentInformation1>
```

## Nominated Dispenser

The prescription message carries the ODS code of the nominated Dispenser seperately from the dispenser type. Nominated dispenser has the xpath `ParentPrescription/pertinentInformation1/pertinentPrescription/performer/AgentOrgSDS/agentOrganizationSDS/id/@extension.`

```xml
<performer contextControlCode="OP" typeCode="PRF">
  <AgentOrgSDS classCode="AGNT">
    <agentOrganizationSDS classCode="ORG" determinerCode="INSTANCE">
      <id extension="FHC38" root="1.2.826.0.1285.0.1.10"/>
    </agentOrganizationSDS>
  </AgentOrgSDS>
</performer>
```

### Example

A complete example is below

```xml
POST /reliablemessaging/reliablerequest HTTP/1.1
Host: msg.int.spine2.ncrs.nhs.uk
SOAPAction: urn:nhs:names:services:mm/PORX_IN020101UK31
Content-Length: 19105
Content-Type: multipart/related; boundary="--=_MIME-Boundary"; type="text/xml"; start="<ebXMLHeader@spine.nhs.uk>"
Connection: close

----=_MIME-Boundary
Content-Id: <ebXMLHeader@spine.nhs.uk>
Content-Type: text/xml; charset=UTF-8
Content-Transfer-Encoding: 8bit

<?xml version="1.0" encoding="UTF-8"?>
<SOAP:Envelope xmlns:xsi="http://www.w3c.org/2001/XML-Schema-Instance" xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/" xmlns:eb="http://www.oasis-open.org/committees/ebxml-msg/schema/msg-header-2_0.xsd" xmlns:hl7ebxml="urn:hl7-org:transport/ebxml/DSTUv1.0" xmlns:xlink="http://www.w3.org/1999/xlink">
<SOAP:Header>
	<eb:MessageHeader SOAP:mustUnderstand="1" eb:version="2.0">
		<eb:From>
			<eb:PartyId eb:type="urn:nhs:names:partyType:ocs+serviceInstance">RHM-801710</eb:PartyId>
		</eb:From>
		<eb:To>
			<eb:PartyId eb:type="urn:nhs:names:partyType:ocs+serviceInstance">YEA-801248</eb:PartyId>
		</eb:To>
		<eb:CPAId>S2001919A2011836</eb:CPAId>
		<eb:ConversationId>4DF40F28-8BF8-11E7-B11A-85A4017EE59E</eb:ConversationId>
		<eb:Service>urn:nhs:names:services:mm</eb:Service>
		<eb:Action>PORX_IN020101UK31</eb:Action>
		<eb:MessageData>
			<eb:MessageId>4DF40F28-8BF8-11E7-B11A-85A4017EE59E</eb:MessageId>
			<eb:Timestamp>2017-08-28T14:53:43Z</eb:Timestamp>
		</eb:MessageData>
		<eb:DuplicateElimination/>
	</eb:MessageHeader>
	<eb:AckRequested SOAP:mustUnderstand="1" eb:version="2.0" eb:signed="false" SOAP:actor="urn:oasis:names:tc:ebxml-msg:actor:toPartyMSH"/>
	<eb:SyncReply SOAP:mustUnderstand="1" eb:version="2.0" SOAP:actor="http://schemas.xmlsoap.org/soap/actor/next"/>
</SOAP:Header>
<SOAP:Body>
	<eb:Manifest SOAP:mustUnderstand="1" eb:version="2.0">
		<eb:Reference xlink:href="cid:4df40f29-8bf8-11e7-b11a-85a4017ee59e@spine.nhs.uk">
			<eb:Schema eb:location="http://www.nhsia.nhs.uk/schemas/HL7-Message.xsd" eb:version="1.0"/>
			<eb:Description xml:lang="en">HL7 payload</eb:Description>
			<hl7ebxml:Payload style="HL7" encoding="XML" version="3.0"/>
		</eb:Reference>

	</eb:Manifest>
</SOAP:Body>
</SOAP:Envelope>

----=_MIME-Boundary
Content-Id: <4df40f29-8bf8-11e7-b11a-85a4017ee59e@spine.nhs.uk>
Content-Type: application/xml; charset=UTF-8
Content-Transfer-Encoding: 8bit

<?xml version="1.0" encoding="UTF-8"?><PORX_IN020101UK31 xmlns="urn:hl7-org:v3">
   <id root="57D11A38-F273-184E-E050-D20AE3A21AB6"/>
   <creationTime value="20170828142318"/>
   <versionCode code="V3NPfIT3.0"/>
   <interactionId extension="PORX_IN020101UK31" root="2.16.840.1.113883.2.1.3.2.4.12"/>
   <processingCode code="P"/>
   <processingModeCode code="T"/>
   <acceptAckCode code="NE"/>
   <communicationFunctionRcv>
      <device classCode="DEV" determinerCode="INSTANCE">
         <id extension="428081423512" root="1.2.826.0.1285.0.2.0.107"/>
      </device>
   </communicationFunctionRcv>
   <communicationFunctionSnd>
      <device classCode="DEV" determinerCode="INSTANCE">
         <id extension="715373337545" root="1.2.826.0.1285.0.2.0.107"/>
      </device>
   </communicationFunctionSnd>
   <ControlActEvent classCode="CACT" moodCode="EVN">
      <author typeCode="AUT">
         <AgentPersonSDS classCode="AGNT">
            <id extension="B0090,B0100,B1510" root="1.2.826.0.1285.0.2.0.67"/>
            <agentPersonSDS classCode="PSN" determinerCode="INSTANCE">
               <id extension="687227875014" root="1.2.826.0.1285.0.2.0.65"/>
            </agentPersonSDS>
            <part typeCode="PART">
               <partSDSRole classCode="ROL">
                  <id extension="S0080:G0450:R5080" root="1.2.826.0.1285.0.2.1.104"/>
               </partSDSRole>
            </part>
         </AgentPersonSDS>
      </author>
      <author1 typeCode="AUT">
         <AgentSystemSDS classCode="AGNT">
            <agentSystemSDS classCode="DEV" determinerCode="INSTANCE">
               <id extension="747225912019" root="1.2.826.0.1285.0.2.0.107"/>
            </agentSystemSDS>
         </AgentSystemSDS>
      </author1>
      <subject>
         <ParentPrescription classCode="INFO" moodCode="EVN">
            <id root="262B835A-87DF-5C94-1BB5-1610DF93E0E4"/>
            <code code="163501000000109" codeSystem="2.16.840.1.113883.2.1.3.2.4.15">
               <originalText>Prescription - FocusActOrEvent </originalText>
            </code>
            <effectiveTime value="20170828120800"/>
            <typeId extension="PORX_MT132004UK31" root="2.16.840.1.113883.2.1.3.2.4.18.7"/>
            <recordTarget typeCode="RCT">
               <Patient classCode="PAT">
                  <id extension="9446369886" root="2.16.840.1.113883.2.1.4.1"/>
                  <addr use="H">
                     <streetAddressLine>5 DENDRUM CLOSE</streetAddressLine>
                     <streetAddressLine>OAKWORTH</streetAddressLine>
                     <streetAddressLine>KEIGHLEY</streetAddressLine>
                     <postalCode>BD22 7JQ</postalCode>
                     <addressKey>30727046</addressKey>
                     <desc/>
                  </addr>
                  <patientPerson classCode="PSN" determinerCode="INSTANCE">
                     <name use="L">
                        <prefix>MR</prefix>
                        <given>MARQUIS</given>
                        <given>OTTO</given>
                        <family>HACKMAN</family>
                        <suffix/>
                     </name>
                     <administrativeGenderCode code="9"/>
                     <birthTime value="19731015"/>
                     <playedProviderPatient classCode="PAT">
                        <subjectOf typeCode="SBJ">
                           <patientCareProvision classCode="PCPR" moodCode="EVN">
                              <code code="1" codeSystem="2.16.840.1.113883.2.1.3.2.4.17.37"/>
                              <responsibleParty typeCode="RESP">
                                 <healthCareProvider classCode="PROV">
                                    <id extension="C81007" root="1.2.826.0.1285.0.1.10"/>
                                 </healthCareProvider>
                              </responsibleParty>
                           </patientCareProvision>
                        </subjectOf>
                     </playedProviderPatient>
                  </patientPerson>
               </Patient>
            </recordTarget>
            <pertinentInformation1 contextConductionInd="true" typeCode="PERT">
               <templateId extension="CSAB_RM-NPfITUK10.pertinentInformation" root="2.16.840.1.113883.2.1.3.2.4.18.2"/>
               <pertinentPrescription classCode="SBADM" moodCode="RQO">
                  <id root="57D11A38-C4A6-184E-E050-D20AE3A21AB6"/>
                  <id extension="5874A0-C81007-EB243K" root="2.16.840.1.113883.2.1.3.2.4.18.8"/>
                  <code code="225426007" codeSystem="2.16.840.1.113883.2.1.3.2.4.15"/>
                  <effectiveTime nullFlavor="NA"/>
                  <performer contextControlCode="OP" typeCode="PRF">
                     <AgentOrgSDS classCode="AGNT">
                        <agentOrganizationSDS classCode="ORG" determinerCode="INSTANCE">
                           <id extension="FHC38" root="1.2.826.0.1285.0.1.10"/>
                        </agentOrganizationSDS>
                     </AgentOrgSDS>
                  </performer>
                  <author contextControlCode="OP" typeCode="AUT">
                     <time value="20170828120800"/>
                     <signatureText><Signature xmlns="http://www.w3.org/2000/09/xmldsig#"><SignedInfo><CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/><SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/><Reference><Transforms><Transform Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#"/></Transforms><DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/><DigestValue>zYKqCBXNBa1AOOUs2bu4HR9lDCA=</DigestValue></Reference></SignedInfo><SignatureValue>Z5YPXJ4p95Ur9n/jazsF3weez4RfBl+t8+4warXMApqab3pezvnYZhanL0HlldFoaBAyYbLh6H/a
SunCzKNqfyMzytAwgsibpt4Kg0E46O909CTxWE2eex79elaYNTqyTpxS09x02x0LxqzxoDt9Gasx
vHUc3HuRAKXJeTS02B5FzBZtSymVQ9Q9ml5MTSLgKKBUOUU3h/XrzgZfRpIkLtWvRHiPtQmnUXoS
L8fACboEtaEKOQeoUXVS9Fgacp9ibRhYuNgidWRiNZChv/5kI9hvvC+GwFg5nshY3l/NpR68FYbA
i7m/R3ELzeyDVfziKnbM0joibV7Hw/qRK3Lr1g==</SignatureValue><KeyInfo><X509Data><X509Certificate>MIIC/DCCAeSgAwIBAgIBBjANBgkqhkiG9w0BAQUFADBIMQ4wDAYDVQQKEwVIU0NJQzERMA8GA1UE
CxMIT3BlbnRlc3QxIzAhBgNVBAMTGkVQUyBOb24tcmVwdWRpYXRpb24gc3ViIENBMB4XDTE2MDEy
NzAwMDAwMFoXDTIwMDEyNjIzNTk1OVowOzEOMAwGA1UEChMFSFNDSUMxGzAZBgNVBAsTElNvbHV0
aW9uIEFzc3VyYW5jZTEMMAoGA1UEAxMDRU1VMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAtVzD2REUbkaHXmiiOpZv2HydnbsmWiEswrcoZjOn7smt6MFbTqFfYcGn1BuZdD8QLe1uRVhH
26XGrEUAfu7CJbZR+mRCs1+84cIxxtB2UxH90FzrehSOrgi06hv8lRzDCxF6KKgCyLPMdJCnAQCX
yyQUh08AX9OEirHJ3mSrVY/bXNXVBaHPNyFrGzg0GJkTNo8iVO73QRYUlJhn5sFZlGWXIbXabc/Q
+Yf9J/NYqid4rXJTIS1qUuAXK5GDHxSAxdoxZQ8+fogDrnyU7Yl7dAATcgk8HUjyhzuInnlpD+nF
I06iOlJg0HJ+TYEmAKgtjL+fxpldP+rPnYJ4cLiCmQIDAQABMA0GCSqGSIb3DQEBBQUAA4IBAQAe
+vIX0QFBMKEcIwTnPEFk8bgrGRMHbKSiVCOM6dgotFlMqfPTuAsRKL0h+2/wqfBs4olM/mjCJ7rk
wUX9BRMdRSfC+SOWvUHG3cUicQETPK3KiJRIQBB48JfR5f/eZIuu9zne4AuSVZYB/qBDnGf+9V/7
I77/4yGpPtOTaDZfZMVB5oNY96B+2/Hd/hTJujljs7KsLSaLkePxlVSa70mSjWJ26cOIk26Q2P82
dl8pqr5R2VLa+0Umdd+LzwFH8m32ufz5hkhahQCiUHRw2NvdkJCsDA6IZQEHchTlr2sMWWxHcoPi
rj2XDBzswwSSYQQ+a3rEFLAREfcd7cSTfbHY</X509Certificate></X509Data></KeyInfo></Signature></signatureText>
                     <AgentPerson classCode="AGNT">
                        <id extension="100111464987" root="1.2.826.0.1285.0.2.0.67"/>
                        <code code="R0260" codeSystem="1.2.826.0.1285.0.2.1.104"/>
                        <telecom use="WP" value="tel:01512631737"/>
                        <agentPerson classCode="PSN" determinerCode="INSTANCE">
                           <id extension="8540087" root="1.2.826.0.1285.0.2.0.65"/>
                           <name use="L">PATIL</name>
                        </agentPerson>
                        <representedOrganization classCode="ORG" determinerCode="INSTANCE">
                           <id extension="C81007" root="1.2.826.0.1285.0.1.10"/>
                           <code code="001" codeSystem="2.16.840.1.113883.2.1.3.2.4.17.94"/>
                           <name>VERNON STREET MEDICAL CTR</name>
                           <telecom use="WP" value="tel:01512631737"/>
                           <addr use="WP">
                              <streetAddressLine>13 VERNON STREET</streetAddressLine>
                              <streetAddressLine>DERBY</streetAddressLine>
                              <streetAddressLine>DERBYSHIRE</streetAddressLine>
                              <postalCode>DE1 1FW</postalCode>
                           </addr>
                           <healthCareProviderLicense classCode="PROV">
                              <Organization classCode="ORG" determinerCode="INSTANCE">
                                 <id extension="5EX" root="1.2.826.0.1285.0.1.10"/>
                                 <code code="005" codeSystem="2.16.840.1.113883.2.1.3.2.4.17.94"/>
                              </Organization>
                           </healthCareProviderLicense>
                        </representedOrganization>
                     </AgentPerson>
                  </author>
                  <responsibleParty contextControlCode="OP" typeCode="RESP">
                     <AgentPerson classCode="AGNT">
                        <id extension="100111464987" root="1.2.826.0.1285.0.2.0.67"/>
                        <code code="R0260" codeSystem="1.2.826.0.1285.0.2.1.104"/>
                        <telecom use="WP" value="tel:01512631737"/>
                        <agentPerson classCode="PSN" determinerCode="INSTANCE">
                           <id extension="G85400" root="1.2.826.0.1285.0.2.0.65"/>
                           <name use="L">PATIL</name>
                        </agentPerson>
                        <representedOrganization classCode="ORG" determinerCode="INSTANCE">
                           <id extension="C81007" root="1.2.826.0.1285.0.1.10"/>
                           <code code="001" codeSystem="2.16.840.1.113883.2.1.3.2.4.17.94"/>
                           <name>VERNON STREET MEDICAL CTR</name>
                           <telecom use="WP" value="tel:01512631737"/>
                           <addr use="WP">
                              <streetAddressLine>13 VERNON STREET</streetAddressLine>
                              <streetAddressLine>DERBY</streetAddressLine>
                              <streetAddressLine>DERBYSHIRE</streetAddressLine>
                              <postalCode>DE1 1FW</postalCode>
                           </addr>
                        </representedOrganization>
                     </AgentPerson>
                  </responsibleParty>
                  <component1 typeCode="COMP">
                     <seperatableInd value="true"/>
                     <daysSupply classCode="SPLY" moodCode="RQO">
                        <code code="373784005" codeSystem="2.16.840.1.113883.2.1.3.2.4.15"/>
                        <effectiveTime/>
                        <expectedUseTime>
                           <width unit="d" value="28"/>
                        </expectedUseTime>
                     </daysSupply>
                  </component1>
                  <pertinentInformation5 contextConductionInd="true" typeCode="PERT">
                     <seperatableInd value="false"/>
                     <pertinentPrescriptionTreatmentType classCode="OBS" moodCode="EVN">
                        <code code="PTT" codeSystem="2.16.840.1.113883.2.1.3.2.4.17.30"/>
                        <value code="0001" codeSystem="2.16.840.1.113883.2.1.3.2.4.16.36"/>
                     </pertinentPrescriptionTreatmentType>
                  </pertinentInformation5>
                  <pertinentInformation1 contextConductionInd="true" typeCode="PERT">
                     <seperatableInd value="true"/>
                     <pertinentDispensingSitePreference classCode="OBS" moodCode="EVN">
                        <code code="DSP" codeSystem="2.16.840.1.113883.2.1.3.2.4.17.30"/>
                        <value code="P1" codeSystem="2.16.840.1.113883.2.1.3.2.4.17.21"/>
                     </pertinentDispensingSitePreference>
                  </pertinentInformation1>
                  <pertinentInformation2 contextConductionInd="true" inversionInd="false" negationInd="false" typeCode="PERT">
                     <seperatableInd value="true"/>
                     <templateId extension="CSAB_RM-NPfITUK10.sourceOf2" root="2.16.840.1.113883.2.1.3.2.4.18.2"/>
                     <pertinentLineItem classCode="SBADM" moodCode="RQO">
                        <id root="57D11A38-E45E-184E-E050-D20AE3A21AB6"/>
                        <code code="225426007" codeSystem="2.16.840.1.113883.2.1.3.2.4.15"/>
                        <effectiveTime nullFlavor="NA"/>
                        <product contextControlCode="OP" typeCode="PRD">
                           <manufacturedProduct classCode="MANU">
                              <manufacturedRequestedMaterial classCode="MMAT" determinerCode="KIND">
                                 <code code="134531009" codeSystem="2.16.840.1.113883.2.1.3.2.4.15" displayName="Almotriptan 12.5mg tablets"/>
                              </manufacturedRequestedMaterial>
                           </manufacturedProduct>
                        </product>
                        <component typeCode="COMP">
                           <seperatableInd value="true"/>
                           <lineItemQuantity classCode="SPLY" moodCode="RQO">
                              <code code="373784005" codeSystem="2.16.840.1.113883.2.1.3.2.4.15"/>
                              <quantity unit="1" value="3">
                                 <translation code="428673006" codeSystem="2.16.840.1.113883.2.1.3.2.4.15" displayName="tablet" value="3">
                                    <originalText/>
                                 </translation>
                              </quantity>
                           </lineItemQuantity>
                        </component>
                        <pertinentInformation1 contextConductionInd="true" typeCode="PERT">
                           <seperatableInd value="false"/>
                           <pertinentAdditionalInstructions classCode="OBS" moodCode="EVN">
                              <code code="AI" codeSystem="2.16.840.1.113883.2.1.3.2.4.17.30"/>
                              <value>&lt;medication&gt;Almotriptan 12.5mg tablets&lt;/medication&gt;&lt;patientInfo&gt; Please call the practice. &lt;/patientInfo&gt;</value>
                           </pertinentAdditionalInstructions>
                        </pertinentInformation1>
                        <pertinentInformation2 contextConductionInd="true" typeCode="PERT">
                           <seperatableInd value="false"/>
                           <pertinentDosageInstructions classCode="OBS" moodCode="EVN">
                              <code code="DI" codeSystem="2.16.840.1.113883.2.1.3.2.4.17.30"/>
                              <value>As Directed</value>
                           </pertinentDosageInstructions>
                        </pertinentInformation2>
                     </pertinentLineItem>
                  </pertinentInformation2>
                  <pertinentInformation8 contextConductionInd="true" typeCode="PERT">
                     <seperatableInd value="false"/>
                     <pertinentTokenIssued classCode="OBS" moodCode="EVN">
                        <code code="TI" codeSystem="2.16.840.1.113883.2.1.3.2.4.17.30"/>
                        <value value="false"/>
                     </pertinentTokenIssued>
                  </pertinentInformation8>
                  <pertinentInformation4 contextConductionInd="true" typeCode="PERT">
                     <seperatableInd value="false"/>
                     <pertinentPrescriptionType classCode="OBS" moodCode="EVN">
                        <code code="PT" codeSystem="2.16.840.1.113883.2.1.3.2.4.17.30"/>
                        <value code="0101" codeSystem="2.16.840.1.113883.2.1.3.2.4.17.25"/>
                     </pertinentPrescriptionType>
                  </pertinentInformation4>
               </pertinentPrescription>
            </pertinentInformation1>
            <pertinentInformation2 typeCode="PERT">
               <templateId extension="CSAB_RM-NPfITUK10.pertinentInformation1" root="2.16.840.1.113883.2.1.3.2.4.18.2"/>
               <pertinentCareRecordElementCategory classCode="CATEGORY" moodCode="EVN">
                  <code code="185361000000102" codeSystem="2.16.840.1.113883.2.1.3.2.4.15"/>
                  <component typeCode="COMP">
                     <actRef classCode="SBADM" moodCode="RQO">
                        <id root="57D11A38-E45E-184E-E050-D20AE3A21AB6"/>
                     </actRef>
                  </component>
               </pertinentCareRecordElementCategory>
            </pertinentInformation2>
         </ParentPrescription>
      </subject>
   </ControlActEvent>
</PORX_IN020101UK31>
----=_MIME-Boundary--
```
