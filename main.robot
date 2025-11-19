*** Settings ***

### Bibliotecas

Library     Collections    # Fornece um conjunto de palavras-chave para lidar com listas e dicionários do Python.
Library     Process    # Biblioteca para execução de processos no sistema.
Library     OperatingSystem    # Uma biblioteca que fornece palavras-chave para tarefas relacionadas ao sistema operacional.
Library     SeleniumLibrary    # SeleniumLibrary é uma biblioteca de teste da Web para Robot Framework.
Library     String    # Biblioteca para gerar, modificar e verificar strings.
Library     DateTime    # Biblioteca para conversões de data e hora.
Library     FakerLibrary    locale=pt_BR    # Biblioteca Faker para geração de dados aleatórios
Library     BuiltIn    #Uma biblioteca padrão sempre disponível com palavras-chave frequentemente necessárias.
Library     XML

### Bibliotecas personalizadas

Library     libraries/command.py    # Métodos de execução robot no console.

*** Variables ***

${PROJECT_PATH}             ${CURDIR}

&{URL}        blog do Agi=https://blogdoagi.com.br/
...           dev=
...           qa=
...           hml=

&{BROWSER}     CHROME=chrome
...            CHROMEHEADLESS=headlesschrome
...            EDGE=edge
...            EDGEHEADLESS=headlessedge
...            FIREFOX=firefox
...            FIREFOXHEADLESS=headlessfirefox