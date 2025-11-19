*** Settings ***

Resource    ../main.robot
Resource    ../helpers/dependencies.robot

*** Keywords ***
Open Browser Selecting Location
    [Documentation]    Abre navegador no ambiente local
    [Arguments]    ${url}    ${browser}    ${local}

    ${local}    Convert To Upper Case    ${local}

    IF    "${local}" == "LOCAL"    # Execução máquina local
        # Abre uma nova instância do navegador para o URL definido.
        Open Browser
        ...    ${url}
        ...    ${browser}
        # ...    options=add_argument("--disable-dev-shm-usage"); add_argument("--no-sandbox"); add_argument("--start-maximized")
        ...    options=add_argument("--disable-dev-shm-usage"); add_argument("--no-sandbox"); add_argument("--headless"); add_argument("--window-size=1366,768")
    END

Get System
    [Arguments]    ${sistema_ambiente}
    ${sistema_ambiente}    Split String    ${sistema_ambiente}    ${SPACE}
    ${sistema_ambiente}    Split String    ${sistema_ambiente}[0]    .
    RETURN    ${sistema_ambiente}[0]

Get Env
    [Arguments]    ${sistema_ambiente}
    ${sistema_ambiente}    Split String    ${sistema_ambiente}    ${SPACE}
    ${sistema_ambiente}    Split String    ${sistema_ambiente}[0]    .
    RETURN    ${sistema_ambiente}[1]

Wait Until Element Is Visible And Capture Screenshot
    [Documentation]    Verifica se elemento é visível e retorna status "True/False".
    ...    "timeout" assume 5 segundos se não for definido
    ...    Para capturar imagem definir o parâmetro "screenshot" como "True".
    [Arguments]    ${element}    ${timeout}=5

    ${visible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${element}    ${timeout}
    Capture Page Screenshot

    IF    ${visible} == True
        Passed Log    Visible "${element}" element
    ELSE
        Fail    *** Elemento "${element}" não visível após ${timeout} segundos
    END

Wait Until Element Is Visible And Capture Element Screenshot
    [Documentation]    Verifica se elemento é visível e retorna status "True/False".
    ...                "timeout" assume 5 segundos se não for definido
    ...                Para capturar imagem do elemento definir o parâmetro "screenshot" como "True".
    [Arguments]    ${element}    ${timeout}=5

    ${visible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${element}    ${timeout}
    Capture Element Screenshot    ${element}

    IF    ${visible} == True
        Passed Log    Visible "${element}" element
    ELSE
        Fail    *** Elemento "${element}" não visível após ${timeout} segundos
    END

Wait Until Element Is Visible And Return Status
    [Documentation]    Verifica se elemento é visível e retorna status "True/False".
    ...    "timeout" assume 5 segundos se não for definido
    ...    Para capturar imagem definir o parâmetro "screenshot" como "True".
    [Arguments]    ${element}    ${timeout}=5    ${screenshot}=False

    ${visible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${element}    ${timeout}
    IF    ${screenshot} == True    Capture Page Screenshot

    RETURN    ${visible}

Perform Click Element
    [Documentation]    Efetua click no elemento.
    ...                Para capturar imagem definir o parâmetro "screenshot" como "True".
    [Arguments]    ${element}    ${screenshot}=True

    ${visible}    Wait Until Element Is Visible And Return Status    ${element}    60

    IF    ${visible} == True
        Click Element    ${element}
    ELSE
        Failure Log    *** Não foi possível clicar no elemento "${element}"
    END

    IF    ${screenshot} == True    Capture Page Screenshot

Fill Field
    [Documentation]    Preenche input com texto.
    ...                Para capturar imagem definir o parâmetro "screenshot" como "True".
    [Arguments]    ${element}    ${text}    ${timeout}=10    ${screenshot}=True

    ${visible}    Wait Until Element Is Visible And Return Status    ${element}    ${timeout}

    IF    ${visible} == True
        Input Text    ${element}    ${text}
    ELSE
        Failure Log    *** Não foi possível preencher o campo "${element}"
    END

    IF    ${screenshot} == True    Capture Page Screenshot

Select New Window
    [Documentation]    Seleciona nova janela apresentada.

    ${new_window_visible}    Set Variable    ${False}

    FOR    ${i}    IN RANGE    0    29
        Sleep    1
        ${handles}    Get Window Handles
        ${length}    Get Length    ${handles}

        IF    ${length} > 1
            ${new_window_visible}    Set Variable    ${True}
            BREAK
        END
    END

    IF    ${new_window_visible} == ${True}
        Switch Window    ${handles}[1]
    ELSE
        Fail    *** Nova janela não foi carregada!
    END

Select Window
    [Documentation]    Seleciona uma aba do navegador.
    [Arguments]    ${num_tab}

    ${handles}    Get Window Handles
    Switch Window    ${handles}[${num_tab}]

Wait Until Element Is Enabled
    [Documentation]    Aguarda o elemento estar habilitado.
    [Arguments]    ${element}    ${text}    ${timeout}=10    ${screenshot}=False

    ${visible}    Set Variable    ${False}

    FOR    ${i}    IN RANGE    1    ${timeout}
        ${visible}    Run Keyword And Return Status    Element Should Be Enabled    ${element}

        IF    ${visible} == ${True}
            BREAK
        END

        Sleep    1
    END

    RETURN    ${visible}

Selected Item Menu
    [Documentation]    Seleciona item de menu.
    ...                element_container_menu: deve receber o elemento que contém todos os links <a> do menu.
    [Arguments]    ${element_container_menu}    ${str_selecionar_item_menu}    ${html_tag}    ${screenshot}=False

    Wait Until Element Is Visible    ${element_container_menu}    10

    @{arr_itens_menus}    Get WebElements    ${element_container_menu}//${html_tag}
    ${bool_item_localizado}    Set Variable    ${False}

    FOR    ${str_item_menu}    IN    @{arr_itens_menus}
        ${str_txt_itens}    Get Text    ${str_item_menu}

        IF    "${str_txt_itens}" == "${str_selecionar_item_menu}"
            Wait Until Element Is Visible    ${str_item_menu}    5
            custom_keywords.Click JavaScript    ${str_item_menu}
            Sleep    0.2
            ${bool_item_localizado}    Set Variable    ${True}
            BREAK
        END
    END

    IF    ${bool_item_localizado} == ${True}
        Log Console And Report    *** Click no item ${str_txt_itens} do menu
    ELSE
        Failure Log    *** Não foi possível efetuar click no item ${str_txt_itens} do menu
    END

    IF    ${screenshot} == True
        Sleep    0.2
        Capture Page Screenshot
    END

Get Text Element
    [Documentation]    Pega texto do elemento.
    [Arguments]    ${element}    ${timeout}=10    ${screenshot}=False

    ${text}    Set Variable    ${EMPTY}
    ${visible}    Wait Until Element Is Visible And Return Status    ${element}    ${timeout}

    IF    ${visible} == True
        # ${text}    Get Text    ${element}
        ${text}    Get Element Attribute    ${element}    value
    ELSE
        Fail    *** Não foi possível pegar o texto do elemento ${element}
    END

    RETURN    ${text}

Scroll Page
    [Documentation]    Efetua click no elemento utilizando javascript.
    [Arguments]    ${position}
    Execute JavaScript    window.scrollTo(0, ${position})
    Sleep    0.2

Send Keys
    [Arguments]    ${key}
    Press Keys    None    ${key}

Click JavaScript
    [Arguments]    ${element}
    Execute Javascript    arguments[0].click();    ARGUMENTS     ${element}