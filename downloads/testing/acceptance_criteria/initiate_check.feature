Feature: Initiating a prescription exemption check

@PEC-FR-20
Scenario: patient under 16
	As a Dispenser at a Healthcare Organisation
	I would like to not carry out a prescripiton exemption check for patients who have automatic exemption
	So that the dispensing process is faster
	Given that I have a prescription for a Patient who is under 16 years of age
	When I request to carry out an exemption check
	Then the system will prevent a check being made 

@PEC-FR-20
Scenario: patient 60 or over
	As a Dispenser at a Healthcare Organisation
	I would like to not carry out a prescripiton exemption check for patients who have automatic exemption
	So that the dispensing process is faster
	Given that I have a prescription for a Patient who is 60 years of age or over
	When  I request to carry out an exemption check
	Then the system will prevent a check being made 
	
@PEC-FR-21
Scenario: Patient a prisoner on release
	As a Dispenser at a Healthcare Organisation
	I would like to not carry out a prescripiton exemption check for patients who have automatic exemption
	So that the dispensing process is faster
	Given that I have a prescription for a Patient who is a prisoner on release
	When  I request to carry out an exemption check
	Then the system will prevent a check being made
	
@PEC-FR-22
Scenario: Contraceptive items
	As a Dispenser at a Healthcare Organisation
	I would like to not carry out a prescripiton exemption check for patients who have automatic exemption
	So that the dispensing process is faster
	Given that I have a prescription for a patient aged between 16 and 60
	And the prescription is for a contraceptive item
	When  I request to carry out an exemption check
	Then the system will prevent a check being made
	
@PEC-FR-22
Scenario: SH endorsement 
	As a Dispenser at a Healthcare Organisation
	I would like to not carry out a prescripiton exemption check for patients who have automatic exemption
	So that the dispensing process is faster
	Given that I have a prescription for a patient aged between 16 and 60
	And the prescription is for an item with the SH endorsement
	When  I request to carry out an exemption check
	Then the system will prevent a check being made
	
@PEC-FR-23 @PEC-FR-25
Scenario: Automatic checking as part of dispensing process
	As a Dispenser at a Healthcare Organisation
	I would like to carry out a prescripiton exemption check as part of my dispensing workflow
	So that the dispensing process is faster
	Given that I have a prescription for a patient aged between 16 and 60
	And the the system is configured with automatic exemption checking within dispensing workflow turned on
	When I dispense the prescription
	Then the system will carry out an exemption check without manual initiation
	
@PEC-FR-23 @PEC-FR-25 @PEC-FR-24 @PEC-FR-26
Scenario: Manual checking as part of dispensing process
	As a Dispenser at a Healthcare Organisation
	I would like to carry out a prescripiton exemption check manually while dispensing
	So that I have control over the dispensing process
	Given that I have a prescription for a patient aged between 16 and 60
	And the the system is configured with automatic exemption checking within dispensing workflow turned off
	When I dispense the prescription
	Then the system will not carry out an exemption check without manual initiation
	
@PEC-FR-27
Scenario: Indicate source of exemption information - information from exemption checking service
	As a Dispenser at a Healthcare Organisation
	I would like to be able to see where information on a patient's exemptions has come from
	So that I can answer patient queries
	Given that I have a prescription for a patient with an exemption recorded in the prescription exemption checking service
	And I have dispensed the prescription
	And the exemption checking service has indicated that the patient has an exemption
	When I view the information about the exemption used for the prescription 
	Then the system indicates that an exemption has been indicated by the exemption checking service
	
@PEC-FR-27
Scenario: Indicate source of exemption information - no information from exemption checking service
	As a Dispenser at a Healthcare Organisation
	I would like to be able to see where information on a patient's exemptions has come from
	So that I can answer patient queries
	Given that I have a prescription for a patient with no exemption recorded in the prescription exemption checking service
	And I have dispensed the prescription
	And the exemption checking service has indicated that an exemption has not been found
	And I have recorded the patient's exemption declaration
	When I view the information about the exemption used for the prescription 
	Then the system indicates that patient has made an exemption declaration
	
@PEC-FR-30	
Scenario: Do not carry out exemption checks for non EPS Rx
	As a Dispenser at a Healthcare Organisation
	I would like to not carry out a prescripiton exemption check for prescriptions where this cannot be recorded
	So that the dispensing process is faster
	Given that I have an EPS Release 1 prescription
	And the patient has an exemption recorded in the prescription exemption checking service
	When  I request to carry out an exemption check
	Then the system will prevent a check being made 