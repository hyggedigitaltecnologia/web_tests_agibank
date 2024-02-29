*** Comments ***

##################################################################################################################################
# Autor: Jhonattan Gomes
# Decrição: Logs de console e report
##################################################################################################################################

*** Settings ***

Resource    ../main.robot    # Importação do arquivo /resources/config.robot que contém todas as Keywords necessárias para o nosso teste.

*** Keywords ***

Log Console And Report
    [Documentation]    Cria log no console e report
    [Arguments]    ${msg}    # Parâmetros repassados para o método.
    Log    ${msg}
    Log To Console    ${msg}

Passed Log
    [Documentation]    Loga passed no report
    [Arguments]    ${msg}
    Log Console And Report    ${msg}

Failure Log
    [Documentation]    Loga fail no report
    [Arguments]    ${msg}
    Run Keyword And Continue On Failure    Fail    ${msg}