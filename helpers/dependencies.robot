*** Settings ***
# Configurações básicas
Resource    ../main.robot

### Helpers ###
Resource    log.robot
Resource    custom_keywords.robot
Resource    javascript_keywords.robot

### Keywords ###
Resource    ../keywords/globais_keywords/globais_keywords.robot
Resource    ../keywords/pesquisa_keywords/pesquisa_keywords.robot

### Pageobjects ###
Resource    ../pages/pesquisa_pages/pesquisa_pages.robot

*** Variables ***
${filled_file}          false
${screenshot_path}      false
${timeout_elements}     180

*** Keywords ***
Run Tests
    [Documentation]    Lê a massa de dados e executa casos de teste
    ...                marcados para execução no Data Manager
    [Arguments]    ${componente}    ${tag}    ${browser}

    ${date}    Get Current Date    result_format=%d%m%Y%H%M%S
    ${cmd}     Set Variable    robot --listener allure_robotframework -i ${tag} -d ./results -x output-xunit.xml --variable BROWSER:${browser} components/${componente}
    Run Command Lines    ${cmd}