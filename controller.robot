*** Comments ***

########################################################################################################################################################
# Autor: Jhonattan Gomes
# Descrição: Responsável pela letuira e execução dos casos de teste
########################################################################################################################################################

*** Settings ***

Resource    helpers/dependencies.robot    # Importação do arquivo main.robot que contém todas as Keywords necessárias para o nosso teste.

*** Variables ***

${COMPONENTE}    componente
${TAG}           tag
${BROWSER}       browser         

*** Test Cases ***

Test Cases
    Run Tests    ${COMPONENTE}    ${TAG}    ${BROWSER}