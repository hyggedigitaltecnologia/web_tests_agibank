*** Comments ***

##################################################################################################################################
# Autor: Jhonattan Gomes
# Decrição: Keywords globais, utilizadas em qualquer teste
##################################################################################################################################

*** Settings ***

Resource    ../../helpers/dependencies.robot    # Importação do arquivo dependencies.robot que contém todas as Keywords necessárias para o nosso teste.

*** Variables ***

${browser}       browser

*** Keywords ***

DADO que acesso o "${ambiente}"

    Open Browser Selecting Location    ${URL}[${ambiente}]    ${browser}    LOCAL
    Maximize Browser Window