##################################################################################################################################
# Autor: Jhonattan Gomes
# Decrição: Chamadas de todas as dependencias.
##################################################################################################################################

*** Settings ***

Resource    ../main.robot    # Configuracoes basicas

### Helpers ###

Resource    log.robot    # Logs de console e relatórios
Resource    custom_keywords.robot    # Keywords customizadas para automação WEB

### Components ###

Resource    ../components/pesquisa/tests/pesquisa_tests.robot

### Keywords ###

Resource    ../keywords/globais_keywords/globais_keywords.robot
Resource    ../keywords/pesquisa_keywords/pesquisa_keywords.robot

### Pageobjects ###

Resource    ../pages/pesquisa_pages/pesquisa_pages.robot

*** Variables ***

${filled_file}              false
${time_out_element}         60

*** Keywords ***

Run Tests
    [Documentation]    Lê e massa de dados e exucuta casos de teste,
    ...                marcados para exeucção no Data Manager
    [Arguments]    ${componente}    ${tag}    ${browser}

    ${date}    Get Current Date    result_format=%d%m%Y%H%M%S    # Captura data/hora atual
    ${cmd}    Set Variable    robot --listener allure_robotframework -i ${tag} -d ./results -x output-xunit.xml --variable BROWSER:${browser} components/${componente}    # Cria pasta com data/hora atual dentro de results para armazenar o relatório
    # ${cmd_allure}    Set Variable    allure generate --clean ./output/allure -o allure-report/    # Cria pasta com data/hora atual dentro de results para armazenar o relatório
    # ${cmd_allure_open}    Set Variable    allure open
    Run Command Lines    ${cmd}    # Executa arquivo tests/tests.robot
    # Run Command Lines    ${cmd_allure}
    # Run Command Lines    ${cmd_allure_open}
    