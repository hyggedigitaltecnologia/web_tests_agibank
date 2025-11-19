*** Settings ***

Resource    ../../../helpers/dependencies.robot    # Importação do arquivo dependencies.robot que contém todas as Keywords necessárias para o nosso teste.

*** Test Cases ***

CT001 - Teste de Pesquisa com Termos Validos
    [Tags]    test    pesquisa_valida

    DADO que acesso o "blog do Agi"
    QUANDO busco por um artigo "valido"
    ENTAO valido carregamento com "sucesso"

CT002 - Teste de Pesquisa com Termos Invalidos
    [Tags]    test    pesquisa_invalida

    DADO que acesso o "blog do Agi"
    QUANDO busco por um artigo "invalido"
    ENTAO valido carregamento com "falha"