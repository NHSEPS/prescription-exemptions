Feature: Authentication and authorization requirements
These are acceptance criteria related to user auth. These may already be met by dispensing systems
	
@PEC-FR-11
Scenario Outline: baseline roles
	As the data controller
	I would like to ensure that only users with the correct roles can access patient exemption data
	So that I can maintain the patient's trust
	Given that I login with the role <role>
	When I authenticate
	Then I should have the baseline activities <activities>

 	Examples:
 	| role | activities |
 	| R8004 | B0401		|
 	| R8003 | B0401 B0825 |
 	

@PEC-FR-12
Scenario: Authorization
	As the data controller
	I would like to ensure that only users with the correct roles can access patient exemption data
	So that I can maintain the patient's trust
	Given that the Dispenser would like to carry out an exemption check
	And the user has authenticated with a role which does not include activity B0570
	When the dispenser requests to carry out an exemption check
	Then the system will prevent the a request being made 
	
@PEC-FR-13
Scenario: User not authenticated 
	As the data controller
	I would like to ensure that only authenticated users can access patient exemption data
	So that I can maintain the patient's trust
	Given that the Dispenser would like to carry out an exemption check
	And the user has not authenticated with a role which includes activity B0570
	When the dispenser requests to carry out an exemption check
	Then the system will prevent the a request being made 
	
@PEC-FR-13
Scenario: User authenticated 
	As the data controller
	I would like to ensure that only authenticated users can access patient exemption data
	So that I can maintain the patient's trust
	Given that the Dispenser would like to carry out an exemption check
	And the user has authenticated with a role which includes activity B0570
	When the dispenser requests to carry out an exemption check
	Then the system will allow the request to be made 
	
@PEC-FR-14
Scenario: User organisation included in request 
	As the NHSBSA
	I would like to record the organisation details of users accessing prescription exemption information
	So that I can maintain the patient's trust
	Given that the Dispenser would like to carry out an exemption check
	And the user has authenticated with a role which includes activity B0570
	And the user has authenticated is working on behalf of an organisation
	When the dispenser requests to carry out an exemption check
	Then the Authorization header in the request includes a valid JWT token
	And the value of the requesting_organization claim in the token is the organisation's ODS code