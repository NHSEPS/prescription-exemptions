Feature: Handling exemption check responses

@PEC-FR-35
Scenario: apply response by default
	As a Dispenser at a HealthCare Organisation
	I would like to be able to have exemption information applied to the prescription by default
	So that I can continue through the dispensing process seamlessly
	Given that I have a prescription to dispense
	And the patient has an exemption recorded in the exemption checking service
	When I request a prescription exemption check
	Then the exemption information is applied to the prescription without further interaction

@PEC-FR-37 @PEC-FR-49.1
Scenario: print token for exempt prescriptions by default configured on
	As NHS England
	I would like dispensers not to print paper tokens where they are not needed for reimbursement
	So that the amount of paper used is reduced
	Given that I have a prescription to dispense
	And the prescription does not include Schedule 2 or 3 Controlled Drugs
	And the patient has an exemption recorded in the exemption checking service
	And the system is configured with print_token_for_exempt_prescriptions turned on
	When I request a prescription exemption check
	Then the system should print a token without further user interaction
	
@PEC-FR-37 @PEC-FR-49.1
Scenario: print token for exemp prescriptions by default configured off
	As NHS England
	I would like dispensers not to print paper tokens where they are not needed for reimbursement
	So that the amount of paper used is reduced
	Given that I have a prescription to dispense
	And the prescription does not include Schedule 2 or 3 Controlled Drugs
	And the patient has an exemption recorded in the exemption checking service
	And the system is configured with print_token_for_exempt_prescriptions turned off
	When I request a prescription exemption check
	Then the system should not print a token without further user interaction
	

@PEC-FR-39 @PEC-FR-45
Scenario: display positive outcome, declaration prompt off
 	As a Dispenser at a HealthCare Organisation
	I would like to be made aware that a prescription exemption applies and that further evidence is not required
	So that the prescription medication can be dispensed at the appropriate charge
	Given that I have a prescription to dispense
	And the patient has an exemption recorded in the exemption checking service
	And the system is configured with prompt_to_obtain_declaration_for_exempt_prescriptions turned off
	When I request a prescription exemption check
	Then the system should inform the user that further evidence is not required
	
@PEC-FR-39 @PEC-FR-45
Scenario: positive outcome, declaration prompt on
 	As a Dispenser at a HealthCare Organisation
	I would like to be made aware that a prescription exemption applies and that further evidence is not required
	So that the prescription medication can be dispensed at the appropriate charge
	Given that I have a prescription to dispense
	And the patient has an exemption recorded in the exemption checking service
	And the system is configured with with prompt_to_obtain_declaration_for_exempt_prescriptions turned on
	When I request a prescription exemption check
	Then the system must indicate the need to obtain an exemption declaration and signature from the Patient or Patients representative
	
@PEC-FR-40 @PEC-FR-41
Scenario: display exemption not found
 	As a Dispenser at a HealthCare Organisation
	I would like to be made aware that a prescription exemption has not been found
	So that I can ask the patient to provide evidence
	Given that I have a prescription to dispense
	And the patient has no exemption recorded in the exemption checking service
	When I request a prescription exemption check
	Then the system must indicate that no exemption has been found
	And the system must indicate the need to obtain an exemption declaration and signature from the Patient or Patients representative
	
@PEC-FR-40 @PEC-FR-42
Scenario: exemption checking service unavailable
 	As a Dispenser at a HealthCare Organisation
	I would like to be made aware that a prescription exemption has not been found
	So that I can ask the patient to provide evidence
	Given that I have a prescription to dispense
	And the exemption checking service is unavailable
	When I request a prescription exemption check
	Then the system must indicate that exemption checking service is unavailable
	And the system must indicate the need to obtain an exemption declaration and signature from the Patient or Patients representative
	
@PEC-FR-40 @PEC-FR-42
Scenario: exemption checking service invalid response
 	As a Dispenser at a HealthCare Organisation
	I would like to be made aware that a prescription exemption has not been found
	So that I can ask the patient to provide evidence
	Given that I have a prescription to dispense
	And the exemption checking service provides an invalid response
	When I request a prescription exemption check
	Then the system must indicate that exemption checking service is unavailable
	And the system must indicate the need to obtain an exemption declaration and signature from the Patient or Patients representative
	
@PEC-FR-44
Scenario: Logging check in audit log
 	As a data controller at a Healthcare Organisation
	I would like details of users using the prescription exemption checking service to be recorded
	So that I can respond to subject access requests and investigate bad practice
	Given that I have a prescription to dispense
	When I request a prescription exemption check
	Then the system must record my details as the user of the service in the audit log
	And the system must record the patient details in the audit log
