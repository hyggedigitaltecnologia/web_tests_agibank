*** Settings ***

Resource    ../../helpers/dependencies.robot    # Importação do arquivo dependencies.robot que contém todas as Keywords necessárias para o nosso teste.

*** Variables ***

${pesquisa_a_search}            xpath=//a[@class='slide-search astra-search-icon'][contains(.,'Pesquisar')]
${pesquisa_ipt_field}           xpath=//input[@id='search-field']
${pesquisa_artigo_valido}       Como Funciona a Portabilidade de Empréstimo Consignado?
${pesquisa_artigo_invalido}     Nada foi encontrado
${pesquisa_artigo_sucesso}      xpath=//a[contains(.,'Como Funciona a Portabilidade de Empréstimo Consignado?')]
${pesquisa_artigo_falha}        xpath=//p[contains(.,'Lamentamos, mas nada foi encontrado para sua pesquisa, tente novamente com outras palavras.')]