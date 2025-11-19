*** Comments ***

##################################################################################################################################
# Autor: Jhonattan Gomes
# Decrição: Pages referentes ao componente de pesquisa
##################################################################################################################################

*** Settings ***

Resource    ../../helpers/dependencies.robot    # Importação do arquivo dependencies.robot que contém todas as Keywords necessárias para o nosso teste.

*** Variables ***

${pesquisa_a_search}      css:div.ast-search-icon a[aria-label="Search button"]
${pesquisa_div_container}   css:div.ast-search-menu-icon.slide-search
${pesquisa_ipt_field}     css:input#search-field
${pesquisa_artigo_valido}       Como Funciona a Portabilidade de Empréstimo Consignado?
${pesquisa_artigo_invalido}     Nada foi encontrado
${pesquisa_artigo_sucesso}      xpath=//a[contains(.,'Como Funciona a Portabilidade de Empréstimo Consignado?')]
${pesquisa_artigo_falha}        xpath=//span[contains(.,'Nada foi encontrado')]

${SEARCH_CONTAINER}    css:div.ast-search-menu-icon.slide-search
${SEARCH_TOGGLE}       css:div.ast-search-icon a[aria-label="Search button"]
${SEARCH_INPUT}        css:input#search-field