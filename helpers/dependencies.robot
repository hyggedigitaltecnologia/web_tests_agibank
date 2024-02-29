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
    ${cmd}    Set Variable    robot -i ${tag} -d ./results --variable browser:${browser} components/${componente}
    Run Command Lines    ${cmd}    # Executa arquivo tests/tests.robot
    