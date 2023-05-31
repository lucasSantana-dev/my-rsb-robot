*** Settings ***
Documentation       Insert the sales data for the week and export it as a PDF
Library             RPA.Browser.Selenium    auto_close=${FALSE}
Library             RPA.HTTP
Library             RPA.Excel.Files
Library             RPA.PDF
Library             RPA.Robocorp.Vault
Resource            Resources/Elements/Main_Elements/main_elements.resource  
Resource            Resources/Elements/login_elements.resource
Resource            Resources/Elements/form_elements.resource
Resource            Resources/Actions/main_actions/main_actions.robot

*** Variables ***
${salesData}             https://robotsparebinindustries.com/SalesData.xlsx

*** Tasks ***
Insert the sales data for the week and export it as a PDF
    Open the intranet website 
    Log in    
    Download the EXCEL file
    Fill the form using the data from the Excel file
    Collect the results
    Export the table as a PDF 
    [Teardown]    Log out and close the browser

