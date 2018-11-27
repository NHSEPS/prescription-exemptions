---
title: Integrating with Prescription Messaging
keywords: develop
tags: [develop]
sidebar: overview_sidebar
permalink: integrating_messaging.html
summary: How to integrate information from the Prescription Exemption Checking Service API with EPS Prescription messaging
---

Once an exemption has been confirmed by a prescription exemption check this confirmation needs to be reflected in the reimbursement claim message for EPS prescriptions. This is done using an extended version of the  *PrescriptionChargeExemption* vocabulary, which includes values which may be returned by a prescription exemption check. Where the patient wishes to claim a different exemption not confirmed by the prescription exemption checking service, then the appropriate value not confirmed by source must be included in the claim message.

## *PrescriptionChargeExemption* vocabulary

The following vocabulary must be used in EPS claim messages.


| *Version:*	| 03    |
| *Date:*	    | 13 June 18  |


| Value	| Description	| Note  |
| ----- | ----------- | ------|
| `0001`	| Patient has paid appropriate charges	 | |
| `0002`	| is under 16 years of age	 | |
| `0003`	| is 16, 17 or 18 and in full-time education	 | |
| `0004`	| is 60 years of age or over	 | |
| `0005`	| has a valid maternity exemption certificate	 | |
| `0006`	| has a valid medical exemption certificate	 | |
| `0007`	| has a valid prescription pre-payment certificate	 | |
| `0008`	| has a War Pension exemption certificate	 | |
| `0009`	| is named on a current HC2 charges certificate	 | |
| `0010`	| was prescribed free-of-charge contraceptives	 | |
| `0011`	| gets income support (IS)	 | |
| `0012`	| gets income based Job Seeker's Allowance (JSA (IB))	 | |
| `0013`	| is entitled to, or named on a VALID NHS tax credit exemption certificate	 |
| `0015` | Patient does not need to pay the prescription charge	| This allows the exemption status to be recorded without actually stating the reason for the exemption.|
| `9005`	| has a valid maternity exemption certificate - confirmed by source	 | |
| Any other value | Patient does not need to pay the prescription charge - confirmed by source	| This allows the exemption status to be confirmed without actually stating the reason for the exemption |


## Exemption Type in the EPS Claim message ##

Exemption type is included in the *Dispense Claim Information interaction (PORX_IN090101UK31)*. It is held at the XPath `DispenseClaim/coverage/coveringChargeExempt/value/@code`


```xml
<coverage typeCode="COVBY" contextConductionInd="true">
  <seperatableInd value="false" />
  <coveringChargeExempt classCode="OBS" moodCode="EVN" negationInd="false">
    <code codeSystem="2.16.840.1.113883.2.1.3.2.4.17.30" code="EX" />
    <value codeSystem="2.16.840.1.113883.2.1.3.2.4.16.33" code="9005" />
  </coveringChargeExempt>
</coverage>
```

### Example

A complete example claim incorporating the extended vocabulary is below:

```xml
POST https://mm-rmasync.national.ncrs.nhs.uk/reliablemessaging/reliablerequest HTTP/1.1
Content-Type: multipart/related; boundary="--=_MIME-Boundary"; type="text/xml"; start="<ebXMLHeader@spine.nhs.uk>"
SOAPAction: "urn:nhs:names:services:mm/PORX_IN090101UK31"
Host: mm-rmasync.national.ncrs.nhs.uk
Content-Length: 27775
Connection: Close

----=_MIME-Boundary
Content-Id: <ebXMLHeader@spine.nhs.uk>
Content-Type: text/xml; charset=UTF-8
Content-Transfer-Encoding: 8bit

<soap:Envelope xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:hl7ebxml="urn:hl7-org:transport/ebxml/DSTUv1.0" xmlns:eb="http://www.oasis-open.org/committees/ebxml-msg/schema/msg-header-2_0.xsd" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <eb:MessageHeader soap:mustUnderstand="1" eb:version="2.0">
      <eb:From>
        <eb:PartyId eb:type="urn:nhs:names:partyType:ocs+serviceInstance">RHM-814382</eb:PartyId>
      </eb:From>
      <eb:To>
        <eb:PartyId eb:type="urn:nhs:names:partyType:ocs+serviceInstance">YEA-0000806</eb:PartyId>
      </eb:To>
      <eb:CPAId>S3114A114825</eb:CPAId>
      <eb:ConversationId>D21676DF-EFFC-4C51-814F-5F7BE7CF3875</eb:ConversationId>
      <eb:Service>urn:nhs:names:services:mm</eb:Service>
      <eb:Action>PORX_IN090101UK31</eb:Action>
      <eb:MessageData>
        <eb:MessageId>D21676DF-EFFC-4C51-814F-5F7BE7CF3875</eb:MessageId>
        <eb:Timestamp>2018-09-04T18:22:45</eb:Timestamp>
      </eb:MessageData>
      <eb:DuplicateElimination />
    </eb:MessageHeader>
    <eb:AckRequested soap:mustUnderstand="1" eb:version="2.0" eb:signed="false" soap:actor="urn:oasis:names:tc:ebxml-msg:actor:toPartyMSH" />
    <eb:SyncReply soap:mustUnderstand="1" eb:version="2.0" soap:actor="http://schemas.xmlsoap.org/soap/actor/next" />
  </soap:Header>
  <soap:Body>
    <eb:Manifest soap:mustUnderstand="1" eb:version="2.0">
      <eb:Reference xlink:href="cid:attachment1@spine.nhs.uk">
        <eb:Schema eb:location="http://www.nhsia.nhs.uk/schemas/HL7-Message.xsd" eb:version="1.0" />
        <eb:Description xml:lang="en-GB">HL7 payload</eb:Description>
        <hl7ebxml:Payload style="HL7" encoding="XML" version="3.0" />
      </eb:Reference>
    </eb:Manifest>
  </soap:Body>
</soap:Envelope>

----=_MIME-Boundary
Content-Id: <attachment1@spine.nhs.uk>
Content-Type: application/xml; charset=UTF-8
Content-Transfer-Encoding: 8bit

<PORX_IN090101UK31 xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:hl7-org:v3">
  <id root="E58AF8CC-1F39-6D22-E040-007F0100149D" />
  <creationTime value="20180904182245" />
  <versionCode code="V3NPfIT4.2.00" />
  <interactionId root="2.16.840.1.113883.2.1.3.2.4.12" extension="PORX_IN090101UK31" />
  <processingCode code="P" />
  <processingModeCode code="T" />
  <acceptAckCode code="NE" />
  <communicationFunctionRcv typeCode="RCV">
    <device classCode="DEV" determinerCode="INSTANCE">
      <id root="1.2.826.0.1285.0.2.0.107" extension="338068513039" />
    </device>
  </communicationFunctionRcv>
  <communicationFunctionSnd typeCode="SND">
    <device classCode="DEV" determinerCode="INSTANCE">
      <id root="1.2.826.0.1285.0.2.0.107" extension="915130719044" />
    </device>
  </communicationFunctionSnd>
  <ControlActEvent xmlns="urn:hl7-org:v3" classCode="CACT" moodCode="EVN">
    <author typeCode="AUT">
      <AgentPersonSDS classCode="AGNT">
        <id root="1.2.826.0.1285.0.2.0.67" extension="942006338565" />
        <agentPersonSDS classCode="PSN" determinerCode="INSTANCE">
          <id root="1.2.826.0.1285.0.2.0.65" extension="893809016032" />
        </agentPersonSDS>
        <part typeCode="PART">
          <partSDSRole classCode="ROL">
            <id root="1.2.826.0.1285.0.2.1.104" extension="S8000:G8000:R8003" />
          </partSDSRole>
        </part>
      </AgentPersonSDS>
    </author>
    <author1 typeCode="AUT">
      <AgentSystemSDS classCode="AGNT">
        <agentSystemSDS classCode="DEV" determinerCode="INSTANCE">
          <id root="1.2.826.0.1285.0.2.0.107" extension="915190729047" />
        </agentSystemSDS>
      </AgentSystemSDS>
    </author1>
    <subject typeCode="SUBJ" contextConductionInd="false">
      <DispenseClaim classCode="INFO" moodCode="EVN">
        <id root="E58AF8CC-1F39-6D22-E040-007F0100149D" />
        <code codeSystem="2.16.840.1.113883.2.1.3.2.4.15" code="163541000000107" displayName="Dispensed Medication" />
        <effectiveTime value="20130904182245" />
        <typeId root="2.16.840.1.113883.2.1.3.2.4.18.7" extension="PORX_MT142001UK31" />
        <primaryInformationRecipient typeCode="PRCP">
          <AgentOrg classCode="AGNT">
            <agentOrganization classCode="ORG" determinerCode="INSTANCE">
              <id root="1.2.826.0.1285.0.1.10" extension="T1450" />
              <name>NHS BSA Prescription Services</name>
            </agentOrganization>
          </AgentOrg>
        </primaryInformationRecipient>
        <pertinentInformation1 typeCode="PERT" contextConductionInd="true">
          <templateId root="2.16.840.1.113883.2.1.3.2.4.18.2" extension="CSAB_RM-NPfITUK10.pertinentInformation" />
          <pertinentSupplyHeader classCode="SBADM" moodCode="EVN">
            <id root="F98EE1A6-8CE4-4287-BBF0-3C6027454328" />
            <code codeSystem="2.16.840.1.113883.2.1.3.2.4.15" code="225426007" />
            <effectiveTime nullFlavor="NA" />
            <repeatNumber>
              <low value="1" />
              <high value="1" />
            </repeatNumber>
            <legalAuthenticator typeCode="LA" contextControlCode="OP">
              <time value="201809040723" />
              <signatureText nullFlavor="NA" />
              <AgentPerson classCode="AGNT">
                <id root="1.2.826.0.1285.0.2.0.67" extension="942006338565" />
                <code codeSystem="1.2.826.0.1285.0.2.1.104" code="S8000:G8000:R8003" />
                <agentPerson classCode="PSN" determinerCode="INSTANCE">
                  <id root="1.2.826.0.1285.0.2.0.65" extension="893809016032" />
                  <name use="L">Steve Williams</name>
                </agentPerson>
                <representedOrganization classCode="ORG" determinerCode="INSTANCE">
                  <id root="1.2.826.0.1285.0.1.10" extension="FML48" />
                  <code codeSystem="2.16.840.1.113883.2.1.3.2.4.17.94" code="003" />
                  <name>Williamsco</name>
                  <telecom use="WP" value="tel:01133974000" />
                  <addr use="WP">
                    <streetAddressLine>The Primary Care Centre</streetAddressLine>
                    <streetAddressLine>Whitehall Road</streetAddressLine>
                    <streetAddressLine>Leeds</streetAddressLine>
                    <postalCode>LS1 4HY</postalCode>
                  </addr>
                </representedOrganization>
              </AgentPerson>
            </legalAuthenticator>
            <pertinentInformation3 typeCode="PERT" contextConductionInd="true">
              <seperatableInd value="false" />
              <pertinentPrescriptionStatus classCode="OBS" moodCode="EVN">
                <code codeSystem="2.16.840.1.113883.2.1.3.2.4.17.30" code="PS" />
                <value codeSystem="2.16.840.1.113883.2.1.3.2.4.16.35" code="0006" displayName="Dispensed" />
              </pertinentPrescriptionStatus>
            </pertinentInformation3>
            <pertinentInformation1 typeCode="PERT" inversionInd="false" contextConductionInd="true" negationInd="false">
              <seperatableInd value="true" />
              <templateId root="2.16.840.1.113883.2.1.3.2.4.18.2" extension="CSAB_RM-NPfITUK10.sourceOf2" />
              <pertinentSuppliedLineItem classCode="SBADM" moodCode="PRMS">
                <id root="9D71192F-D17A-46C8-AF5F-EB3032284042" />
                <code codeSystem="2.16.840.1.113883.2.1.3.2.4.15" code="225426007" />
                <effectiveTime nullFlavor="NA" />
                <repeatNumber>
                  <low value="1" />
                  <high value="1" />
                </repeatNumber>
                <component typeCode="COMP">
                  <seperatableInd value="false" />
                  <suppliedLineItemQuantity classCode="SPLY" moodCode="EVN">
                    <code codeSystem="2.16.840.1.113883.2.1.3.2.4.15" code="373784005" />
                    <quantity value="100" unit="1">
                      <translation value="100" codeSystem="2.16.840.1.113883.2.1.3.2.4.15" code="428673006" displayName="tablet" />
                    </quantity>
                    <product typeCode="PRD" contextControlCode="OP">
                      <suppliedManufacturedProduct classCode="MANU">
                        <manufacturedSuppliedMaterial classCode="MMAT" determinerCode="INSTANCE">
                          <code codeSystem="2.16.840.1.113883.2.1.3.2.4.15" code="1251111000001105" displayName="Paracetamol 500mg tablets 100 tablet">
                            <originalText>Paracetamol 500mg tablets</originalText>
                          </code>
                        </manufacturedSuppliedMaterial>
                      </suppliedManufacturedProduct>
                    </product>
                    <pertinentInformation1 typeCode="PERT" contextConductionInd="true">
                      <seperatableInd value="false" />
                      <pertinentChargePayment classCode="OBS" moodCode="EVN">
                        <code codeSystem="2.16.840.1.113883.2.1.3.2.4.17.30" code="CP" />
                        <value value="false" />
                      </pertinentChargePayment>
                    </pertinentInformation1>
                    <pertinentInformation2 typeCode="PERT" contextConductionInd="true">
                      <seperatableInd value="true" />
                      <pertinentDispensingEndorsement classCode="OBS" moodCode="EVN">
                        <code codeSystem="2.16.840.1.113883.2.1.3.2.4.17.30" code="DE" />
                        <value codeSystem="2.16.840.1.113883.2.1.3.2.4.16.29" code="NDEC" />
                      </pertinentDispensingEndorsement>
                    </pertinentInformation2>
                  </suppliedLineItemQuantity>
                </component>
                <pertinentInformation1 typeCode="PERT" contextConductionInd="true">
                  <seperatableInd value="false" />
                  <pertinentRunningTotal classCode="OBS" moodCode="EVN">
                    <code codeSystem="2.16.840.1.113883.2.1.3.2.4.17.30" code="RT" />
                    <value value="100" unit="1">
                      <translation value="100" codeSystem="2.16.840.1.113883.2.1.3.2.4.15" code="428673006" displayName="tablet" />
                    </value>
                  </pertinentRunningTotal>
                </pertinentInformation1>
                <pertinentInformation3 typeCode="PERT" contextConductionInd="true">
                  <seperatableInd value="false" />
                  <pertinentItemStatus classCode="OBS" moodCode="EVN">
                    <code codeSystem="2.16.840.1.113883.2.1.3.2.4.17.30" code="IS" />
                    <value codeSystem="2.16.840.1.113883.2.1.3.2.4.17.23" code="0001" displayName="Item fully dispensed" />
                  </pertinentItemStatus>
                </pertinentInformation3>
                <inFulfillmentOf typeCode="FLFS" inversionInd="false" negationInd="false">
                  <seperatableInd value="true" />
                  <templateId root="2.16.840.1.113883.2.1.3.2.4.18.2" extension="CSAB_RM-NPfITUK10.sourceOf1" />
                  <priorOriginalItemRef classCode="SBADM" moodCode="RQO">
                    <id root="D8D6D523-4691-4751-B2D5-1221B725EC99" />
                  </priorOriginalItemRef>
                </inFulfillmentOf>
              </pertinentSuppliedLineItem>
            </pertinentInformation1>
            <pertinentInformation4 typeCode="PERT" contextConductionInd="true">
              <seperatableInd value="false" />
              <pertinentPrescriptionID classCode="OBS" moodCode="EVN">
                <code codeSystem="2.16.840.1.113883.2.1.3.2.4.17.30" code="PID" />
                <value root="2.16.840.1.113883.2.1.3.2.4.18.8" extension="2BE1EA-L36920-0353AW" />
              </pertinentPrescriptionID>
            </pertinentInformation4>
            <inFulfillmentOf typeCode="FLFS" inversionInd="false" negationInd="false">
              <seperatableInd value="true" />
              <templateId root="2.16.840.1.113883.2.1.3.2.4.18.2" extension="CSAB_RM-NPfITUK10.sourceOf1" />
              <priorOriginalPrescriptionRef classCode="SBADM" moodCode="RQO">
                <id root="AA46B163-4DD4-4CEA-9511-74D560C9E3BE" />
              </priorOriginalPrescriptionRef>
            </inFulfillmentOf>
            <predecessor typeCode="SUCC" inversionInd="false" negationInd="false">
              <seperatableInd value="true" />
              <templateId root="2.16.840.1.113883.2.1.3.2.4.18.2" extension="CSAB_RM-NPfITUK10.sourceOf1" />
              <priorSupplyHeaderRef classCode="SBADM" moodCode="EVN">
                <id root="D8407BB4-2B6D-4B17-BFA6-55C96AD8B246" />
              </priorSupplyHeaderRef>
            </predecessor>
          </pertinentSupplyHeader>
        </pertinentInformation1>
        <coverage typeCode="COVBY" contextConductionInd="true">
          <seperatableInd value="false" />
          <coveringChargeExempt classCode="OBS" moodCode="EVN" negationInd="false">
            <code codeSystem="2.16.840.1.113883.2.1.3.2.4.17.30" code="EX" />
            <value codeSystem="2.16.840.1.113883.2.1.3.2.4.16.33" code="9005" />
          </coveringChargeExempt>
        </coverage>
        <sequelTo typeCode="SEQL">
          <priorPrescriptionReleaseEventRef classCode="INFO" moodCode="RQO">
            <id root="51F6E330-BC4A-4CDA-B6D3-FB0110D45C22" />
          </priorPrescriptionReleaseEventRef>
        </sequelTo>
      </DispenseClaim>
    </subject>
  </ControlActEvent>
</PORX_IN090101UK31>
----=_MIME-Boundary--
```
