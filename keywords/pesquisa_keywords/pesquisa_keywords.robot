*** Settings ***

Resource    ../../helpers/dependencies.robot    # Importação do arquivo dependencies.robot que contém todas as Keywords necessárias para o nosso teste.

*** Variables ***

*** Keywords ***

QUANDO busco por um artigo "${texto}"

    IF    "${texto}" == "valido"
        Fill Field    ${pesquisa_ipt_field}    ${pesquisa_artigo_valido}
    ELSE IF    "${texto}" == "invalido"
        Fill Field    ${pesquisa_ipt_field}    ${pesquisa_artigo_invalido}
    END

    Send Keys    RETURN

ENTAO valido carregamento com "${status}"

    IF    "${status}" == "sucesso"
        Wait Until Element Is Visible And Capture Screenshot    ${pesquisa_artigo_sucesso}    ${time_out_element}
    ELSE IF    "${status}" == "falha"
        Wait Until Element Is Visible And Capture Screenshot    ${pesquisa_artigo_falha}    ${time_out_element}
    END