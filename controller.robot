*** Settings ***

Resource    helpers/dependencies.robot    # Importação do arquivo main.robot que contém todas as Keywords necessárias para o nosso teste.

Test Teardown    Close Browser

*** Variables ***

${COMPONENTE}    componente
${TAG}           tag
${BROWSER}       browser

*** Test Cases ***

Test Cases
    Run Tests    ${COMPONENTE}    ${TAG}    ${BROWSER}