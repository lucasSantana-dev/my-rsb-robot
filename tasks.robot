*** Settings ***
Documentation       Insert the sales data for the week and export it as a PDF
Library             RPA.Browser.Selenium    auto_close=${FALSE}
Library             RPA.HTTP
Library             RPA.Excel.Files
Library             RPA.PDF
Library             RPA.Robocorp.Vault
Resource            Resources/Elements/Main_Elements/main_elements.resource  
#Resource            Resources/Elements/login_elements.resource
#Resource            Resources/Elements/form_elements.resource
  
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

*** Keywords ***
Open the intranet website
    Open Available Browser    https://robotsparebinindustries.com/

Log in
    ${secret}=    Get Secret    credentials
    Input Text        ${login_Page.input_Username}    ${secret}[username]   
    Input Password    ${login_Page.input_Password}    ${secret}[password]  
    Submit Form 
    Wait Until Page Contains Element       ${form_Page.input_Firstname}

Fill and submit the form for one person
    [Arguments]                            ${sales_Rep}
    Input Text                             ${form_Page.input_Firstname}         ${sales_Rep}[First Name]
    Input Text                             ${form_Page.input_Lastname}          ${sales_Rep}[Last Name]
    Input Text                             ${form_Page.input_Salesresult}       ${sales_Rep}[Sales]
    Select From List By Value              ${form_Page.select_Salestarget}      ${sales_Rep}[Sales Target]
    Click Button                           ${form_Page.button_Submit}

Fill the form using the data from the Excel file
    Open Workbook     SalesData.xlsx
    ${sales_Reps}=    Read Worksheet As Table    header=${True}
    Close Workbook
    FOR    ${sales_Rep}    IN    @{sales_Reps}
        Fill and submit the form for one person    ${sales_Rep}
    END

Download the EXCEL file
    Download    ${salesData}    overwrite=${True}

Collect the results
    Screenshot    css:div.sales-summary    ${OUTPUT_DIR}${/}sales_summary.png    

Export the table as a PDF 
    Wait Until Element Is Visible    id:sales-results
    ${sales_Results_html}=    Get Element Attribute    id:sales-results    outerHTML
    Html To Pdf    ${sales_Results_html}    ${OUTPUT_DIR}${/}sales_results.pdf

Log out and close the browser
    Click Button    Log out
    Close Browser