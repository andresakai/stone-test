Feature: Transfer between internal accounts
    As a Stone user
    I want to transfer to another Stone user

Background: Load variables from params, get authorization and get account ID
    Given user stores the following list of variables:
            | "base_url" | "${params.[$.default.base_url]}" |
            | "username" | "${params.[$.default.username]}" |
            | "password" | "${params.[$.default.password]}" | 
            | "api_url"  | "${params.[$.default.api_url]}"  |
      And (api) user creates a POST request to '${vars.base_url}/auth/realms/stone_bank/protocol/openid-connect/token'
      And (api) user sets the following headers to request:
        | "Content-Type" | "application/x-www-form-urlencoded" |
      And (api) user add the following value to BODY request:
        """
        client_id=admin-cli&username=${vars.username}&password=${vars.password}&grant_type=password
        """
      And (api) user sends the request
      And (api) the response status should be '200'
      And (api) user stores the value '$.access_token' from response in variable 'access_token' 
      And (api) user creates a GET request to '${vars.api_url}/api/v1/accounts'
      And (api) user sets the following headers to request:
        | "Authorization" | "Bearer ${vars.access_token}" |
      And (api) user sends the request
      And (api) the response status should be '200'
      And (api) user stores the value '$[0].id' from response in variable 'account_id'


Scenario: Making an internal transfer, validating balance and checking target account

Scenario: Cancelling internal transfer, and validating balance

Scenario: Returning an internal trasnfer, and validanting balance

Scenario: Making an invalid transfer with , validating balance

Scenario: Making an invalid transfer to invalid account, validating balance

Scenario: Making an invalid transfer with zero amount, validating balance

Scenario: Making an invalid transfer with invalid amount (not int),validating balance