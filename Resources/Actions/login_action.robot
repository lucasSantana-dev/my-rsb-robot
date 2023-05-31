*** Settings ***
Library      RPA.Browser.Selenium
Library      RPA.Robocorp.Vault
Resource     Resources/Elements/Main_Elements/main_elements.resource  


*** Keywords ***
Log in
    ${secret}=    Get Secret    credentials
    Input Text        ${login_Page.input_Username}    ${secret}[username]   
    Input Password    ${login_Page.input_Password}    ${secret}[password]  
    Submit Form 
    Wait Until Page Contains Element       ${form_Page.input_Firstname}
