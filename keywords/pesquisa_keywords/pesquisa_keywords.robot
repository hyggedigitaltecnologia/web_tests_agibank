*** Comments ***

##################################################################################################################################
# Autor: Jhonattan Gomes
# Decrição: Keywords referentes ao componente de pesquisa
##################################################################################################################################

*** Settings ***

Resource    ../../helpers/dependencies.robot    # Importação do arquivo dependencies.robot que contém todas as Keywords necessárias para o nosso teste.

*** Variables ***

*** Keywords ***

QUANDO busco por um artigo "${texto}"

    Esperar Pagina Carregada

    Abrir Campo De Pesquisa

    IF    '${texto}' == 'valido'
        Fill Field    ${SEARCH_INPUT}    ${pesquisa_artigo_valido}
    ELSE IF    '${texto}' == 'invalido'
        Fill Field    ${SEARCH_INPUT}    ${pesquisa_artigo_invalido}
    ELSE
        Fail    Tipo de texto não mapeado: ${texto}
    END

    Press Keys    ${SEARCH_INPUT}    RETURN

ENTAO valido carregamento com "${status}"

    IF    "${status}" == "sucesso"
        Wait Until Element Is Visible And Capture Screenshot    ${pesquisa_artigo_sucesso}    ${timeout_elements}
    ELSE IF    "${status}" == "falha"
        Wait Until Element Is Visible And Capture Screenshot    ${pesquisa_artigo_falha}    ${timeout_elements}
    END