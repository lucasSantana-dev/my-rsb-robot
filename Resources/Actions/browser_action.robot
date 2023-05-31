*** Settings ***
library    RPA.Browser.Selenium

*** Keywords ***
Open the intranet website
    Open Available Browser    https://robotsparebinindustries.com/

Log out and close the browser
    Click Button    Log out
    Close Browser