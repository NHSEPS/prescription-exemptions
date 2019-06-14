Feature: Demographics requirements
These are acceptance criteria related to patient demographics and functioning alongside Spine Demographics. 
Test patients with prescriptions are available in the appropriate states. 

@PEC-FR-3 @PEC-FR-5
Scenario: PDS attributes synced
	As a Dispenser at a HealthCare Organisation
	I would like to be able to sync patient attributes from Spine demographics with the local demographic record
	So that accurate demographic data is utilised by the exemption checking service
	Given that the Dispenser has downloaded a prescription
	When the local record patient attributes are synchronised with Spine demographics
	Then the following details will be synchronised: Usual name, usual address, date of birth and gender

@PEC-FR-4
Scenario: PDS attributes not synced
	As a Dispenser at a HealthCare Organisation
	I would like to be able to sync patient attributes from Spine demographics with the local demographic record
	So that accurate demographic data is utilised by the exemption checking service
	Given that the Dispenser has downloaded a prescription
	And the local record patient attributes are  unable to be synchronised with Spine demographics
	Then the system will prevent the a request being made
	
@PEC-FR-4
Scenario: PDS tel not synced
	As a Dispenser at a HealthCare Organisation
	I would like to be able to ensure patient telecom attributes from Spine demographics are not automatically synced
	So that synchronisation overheads are kept to a minimum
	Given that the Dispenser has downloaded a prescription
	When the local record patient attributes are synchronised with Spine demographics 
	Then the patient telecom details will not be automatically synchronised  including 'use' attributes
	
@PEC-FR-5
Scenario: Non synced patients not able to be checked
	As a Dispenser at a HealthCare Organisation
	I would like to be able to sync patient attributes from Spine demographics
	So that an exemption check can be carried out
	Given that the Dispenser would like to carry out an exemption check
	And the patient demographic record has not been synchronised with Spine
	When the dispenser requests to carry out an exemption check
	Then the system will prevent the a request being made
	
@PEC-FR-6
Scenario: Informally deceased patients not able to be checked
	As a Dispenser at a HealthCare Organisation
	I would like to be able to carry out a prescription exemption check
	So that the prescription medication can be dispensed with at the appropriate 
	Given that the Dispenser would like to carry out an exemption check
	And the Patient is recorded as informally deceased
	When the dispenser requests to carry out an exemption check
	Then the system will prevent the a request being made 
	
@PEC-FR-6
Scenario: Formally deceased patients not able to be checked
	As a Dispenser at a HealthCare Organisation
	I would like to be able to carry out a prescription exemption check
	So that the prescription medication can be dispensed with at the appropriate 
	Given that the Dispenser would like to carry out an exemption check
	And the Patient is recorded as formally deceased
	When the dispenser requests to carry out an exemption check
	Then the system will prevent the a request being made
	
@PEC-FR-7
Scenario: Sensitive flagged patients not able to be checked
	As a Dispenser at a HealthCare Organisation
	I would like to be able to carry out a prescription exemption check
	So that the prescription medication can be dispensed with at the appropriate 
	Given that the Dispenser would like to carry out an exemption check
	And the Patient is flagged as sensitive
	When the dispenser requests to carry out an exemption check
	Then the system will prevent the a request being made 
	
@PEC-FR-8
Scenario: Patient with demographics containing bad data not able to be checked
	As the NHSBSA
	I would like queries sent to me to only contain valid deta
	So that the service works as expected
	Given that the Dispenser would like to carry out an exemption check
	And the Patient  demographics contain invalid characters
	When the dispenser requests to carry out an exemption check
	Then the system will prevent the a request being made 
