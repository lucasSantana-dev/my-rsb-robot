*** Settings ***
Library    RPA.Browser.Selenium
Library    RPA.HTTP
Library    RPA.Excel.Files
Library    RPA.PDF
Resource   ../Elements/Main_Elements/main_elements.resource 

*** Variables ***
${salesData}     https://robotsparebinindustries.com/SalesData.xlsx

*** Keywords ***
Download the EXCEL file
    Download    ${salesData}    overwrite=${True}

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

Export the table as a PDF 
    Wait Until Element Is Visible    id:sales-results
    ${sales_Results_html}=    Get Element Attribute    id:sales-results    outerHTML
    Html To Pdf    ${sales_Results_html}    ${OUTPUT_DIR}${/}sales_results.pdf

Collect the results
    Screenshot    css:div.sales-summary    ${OUTPUT_DIR}${/}sales_summary.png    
