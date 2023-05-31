*** Settings ***
Documentation    neste arquivo estão os elementos da pagina contendo
...              o formulario de vendas

*** Variables ***
&{form_Page}
...            input_Firstname=firstname
...            input_Lastname=//input[@name='lastname']
...            input_Salesresult=salesresult
...            select_Salestarget=salestarget
...            button_Submit=//button[contains(@type,'submit')]
