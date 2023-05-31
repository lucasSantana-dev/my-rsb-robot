*** Settings ***
Documentation    neste arquivo estarão os elements da pagina de login

*** Variables ***
&{login_Page}
...            input_Username=//input[contains(@name,'username')]
...            input_Password=//input[contains(@type,'password')]
