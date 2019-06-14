Feature: Handling exemption check responses

@PEC-FR-50
Scenario: exemption service response included in claim message
	As the NHSBSA
	I want the patient's exemption to be accurately reported
	So that I can report the correct number of exemptions claimed to the health service
	Given that I have a prescription to dispense
	And the patient has an exemption recorded in the exemption checking service
	When I request a prescription exemption check
	Then The exemption type given in the prescription exemption check response must be included in the claim message
	And the description matching the code must be included in the claim message

@PEC-FR-50
Scenario: universal credit declared by patient
	As the NHSBSA
	I want the patient's exemption to be accurately reported
	So that I can report the correct number of exemptions claimed to the health service
	Given that I have a prescription to dispense
	And the patient does not have an exemption recorded in the exemption checking service
	And the patient declares a Universal Credit exemption
	When I submit a claim message
	Then The exemption type code is '0016'
	And the description is 'gets Universal Credit (and meets eligibility criteria)'
	
	
@PEC-FR-50
Scenario: SH prescriber endorsement
	As the NHSBSA
	I want the patient's exemption to be accurately reported
	So that I can report the correct number of exemptions claimed to the health service
	Given that I have a prescription to dispense
	And the prescribed item has the prescriber endorsement 'SH'
	When I submit a claim message
	Then The exemption type code is '0010'
	And the description is 'was prescribed free-of-charge sexual health medication'
	
@PEC-FR-52
Scenario: claim amendment
	As the NHSBSA
	I want the patient's exemption to be accurately reported
	So that I can report the correct number of exemptions claimed to the health service
	Given I have claimed a prescription
	And I amend a claimed item
	When I submit a claim amendment
	Then The system must not perform an exemption check