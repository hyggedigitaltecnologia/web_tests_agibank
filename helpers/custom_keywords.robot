*** Settings ***

Resource    ../main.robot
Resource    ../helpers/dependencies.robot

*** Keywords ***
Open Browser Selecting Location
    [Documentation]    Abre navegador no ambiente local ou remoto selecionado.
    ...    Parametros: local e remote_url são obrigatórios em caso de execução remota.
    [Arguments]    ${url}    ${browser}

    Log To Console    ${\n}
    Log To Console    ---------------------------------------------------
    Log Console And Report    *** Ambiente: ${url}
    Log Console And Report    *** Browser: ${browser}

    Open Browser
    ...    ${url}
    ...    ${browser}
    ...    options=set_capability("goog:loggingPrefs", {"performance":"ALL","browser":"ALL"}); add_argument("--headless"); add_argument("--window-size=1920,1080"); add_argument("--disable-dev-shm-usage"); add_argument("--no-sandbox"); add_argument("--disable-blink-features=AutomationControlled"); add_experimental_option("excludeSwitches", ["enable-automation"]); add_experimental_option("useAutomationExtension", False); add_argument("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123 Safari/537.36")

    Set Window Size    1920    1080    True

    # Open Browser
    # ...    ${url}
    # ...    ${browser}
    # ...    options=set_capability("goog:loggingPrefs", {"performance":"ALL","browser":"ALL"}); add_argument("--window-size=1920,1080"); add_argument("--disable-dev-shm-usage"); add_argument("--no-sandbox"); add_argument("--disable-blink-features=AutomationControlled"); add_experimental_option("excludeSwitches", ["enable-automation"]); add_experimental_option("useAutomationExtension", False); add_argument("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123 Safari/537.36")

    # Maximize Browser Window

    # ${windows_size}    Get Window Size
    # Passed Log    ${windows_size}

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
    [Arguments]    ${element}    ${timeout}=${timeout_elements}

    ${visible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${element}    ${timeout}
    Capture Screenshot For Test

    IF    ${visible} == True
        Passed Log    Visible "${element}" element
    ELSE
        Fail    *** Elemento "${element}" não visível após ${timeout} segundos
    END

Wait Until Element Is Visible And Capture Element Screenshot
    [Documentation]    Verifica se elemento é visível e retorna status "True/False".
    ...                "timeout" assume 5 segundos se não for definido
    ...                Para capturar imagem do elemento definir o parâmetro "screenshot" como "True".
    [Arguments]    ${element}    ${timeout}=${timeout_elements}

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
    [Arguments]    ${element}    ${timeout}=${timeout_elements}    ${screenshot}=False

    ${visible}    Run Keyword And Return Status    Wait Until Element Is Visible    ${element}    ${timeout}
    IF    ${screenshot} == True    Capture Screenshot For Test

    RETURN    ${visible}

Perform Click Element
    [Documentation]    Efetua click no elemento.
    ...                Para capturar imagem definir o parâmetro "screenshot" como "True".
    [Arguments]    ${element}    ${timeout}=${timeout_elements}    ${screenshot}=True

    ${visible}    Wait Until Element Is Visible And Return Status    ${element}    ${timeout_elements}

    IF    ${visible} == True
        Click Element    ${element}
        Passed Log    *** Click Element ${element}
    ELSE
        Fail    *** Não foi possível clicar no elemento "${element}"
    END

    IF    ${screenshot} == True    Capture Screenshot For Test

Fill Field
    [Documentation]    Preenche input com texto.
    ...                Para capturar imagem definir o parâmetro "screenshot" como "True".
    [Arguments]    ${element}    ${text}    ${timeout}=${timeout_elements}    ${screenshot}=True

    ${visible}    Wait Until Element Is Visible And Return Status    ${element}    ${timeout}

    IF    ${visible} == True
        Input Text    ${element}    ${text}
        Passed Log    Input Text ${element} ${text}
    ELSE
        Fail    *** Não foi possível preencher o campo "${element}"
    END

    IF    ${screenshot} == True    Capture Screenshot For Test

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
    [Arguments]    ${element}    ${text}    ${timeout}=${timeout_elements}    ${screenshot}=False

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

    Wait Until Element Is Visible    ${element_container_menu}    ${timeout_elements}

    @{arr_itens_menus}    Get WebElements    ${element_container_menu}//${html_tag}
    ${bool_item_localizado}    Set Variable    ${False}

    FOR    ${str_item_menu}    IN    @{arr_itens_menus}
        ${str_txt_itens}    Get Text    ${str_item_menu}

        IF    "${str_txt_itens}" == "${str_selecionar_item_menu}"
            Wait Until Element Is Visible    ${str_item_menu}    5
            Click Element Via Js    ${str_item_menu}
            Sleep    0.2
            ${bool_item_localizado}    Set Variable    ${True}
            BREAK
        END
    END

    IF    ${bool_item_localizado} == ${True}
        Log Console And Report    *** Click no item ${str_txt_itens} do menu
    ELSE
        Fail    *** Não foi possível efetuar click no item ${str_txt_itens} do menu
    END

    IF    ${screenshot} == True
        Sleep    0.2
        Capture Screenshot For Test
    END

Get Text Element
    [Documentation]    Pega texto do elemento.
    [Arguments]    ${element}    ${timeout}=${timeout_elements}    ${screenshot}=False

    ${text}    Set Variable    ${EMPTY}
    ${visible}    Wait Until Element Is Visible And Return Status    ${element}    ${timeout}

    IF    ${visible} == True
        # ${text}    Get Text    ${element}
        ${text}    SeleniumLibrary.Get Element Attribute    ${element}    value
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

Capture Screenshot For Test

    IF    "${screenshot_path}" == "false"
        Create Directory    ${project_path}/results/${TEST NAME}
        Wait Until Created    ${project_path}/results/${TEST NAME}
        ${screenshot_path}    Set Variable    true
        SeleniumLibrary.Set Screenshot Directory    ${project_path}/results/${TEST NAME}
        Capture Page Screenshot
    ELSE
        Capture Page Screenshot
    END

Esperar Pagina Carregada
    [Documentation]    Aguarda até que o DOM esteja completamente carregado (document.readyState = complete).
    Wait Until Keyword Succeeds    10x    0.5s    Verificar Estado Da Pagina

Verificar Estado Da Pagina
    [Documentation]    Verifica o estado atual do documento via JavaScript.
    ${state}=    Execute Javascript    return document.readyState;
    Should Be Equal    ${state}    complete

Header Search Deve Estar Aberta
    [Documentation]    Garante que o container de busca está aberto e o campo de pesquisa utilizável.
    ${classes}=    SeleniumLibrary.Get Element Attribute    ${SEARCH_CONTAINER}    class
    Log    Classes do container de busca: ${classes}
    Should Contain    ${classes}    ast-dropdown-active
    Element Should Be Visible    ${SEARCH_INPUT}

Abrir Campo De Pesquisa
    [Documentation]    Abre o campo de busca do header usando fallback: clique normal, botão de submit e JS.
    # 1) Tenta clicar no ícone padrão da lupa (anchor)
    ${clicou}=    Run Keyword And Return Status    Click Element    ${pesquisa_a_search}

    # 2) Se não clicou, tenta o botão de submit da busca
    IF    not ${clicou}
        ${clicou}=    Run Keyword And Return Status
        ...    Click Element
        ...    css:button.search-submit.ast-search-submit
    END

    # 3) Se ainda não deu, usa JavaScript para encontrar e clicar em algum botão/anchor de busca
    IF    not ${clicou}
        Execute JavaScript
        ...    (function() {
        ...        var candidates = Array.from(document.querySelectorAll('button, a'));
        ...        var searchBtn = candidates.find(function(btn) {
        ...            var text = (btn.textContent || '').toLowerCase();
        ...            var aria = (btn.getAttribute('aria-label') || '').toLowerCase();
        ...            var cls  = (btn.className || '').toLowerCase();
        ...            return text.includes('pesquisar')
        ...                || text.includes('search')
        ...                || aria.includes('search')
        ...                || cls.includes('search');
        ...        });
        ...        if (searchBtn) {
        ...            searchBtn.click();
        ...        }
        ...    })();
    END

    # 4) Garante que o campo #search-field fique utilizável (classe + estilo + foco)
    Wait Until Keyword Succeeds    5x    1s    Forcar Campo De Busca Visivel

Forcar Campo De Busca Visivel
    [Documentation]    Força a abertura do header search, ajustando classe e estilo do campo.
    Execute JavaScript
    ...    (function() {
    ...        var root = document.querySelector('.ast-search-menu-icon.slide-search');
    ...        if (root && !root.classList.contains('ast-dropdown-active')) {
    ...            root.classList.add('ast-dropdown-active');
    ...        }
    ...        var f = document.getElementById('search-field');
    ...        if (f) {
    ...            f.style.display    = 'block';
    ...            f.style.visibility = 'visible';
    ...            f.style.opacity    = '1';
    ...            f.removeAttribute('tabindex');
    ...            f.tabIndex = 0;
    ...            f.focus();
    ...        }
    ...    })();

    Wait Until Page Contains Element    ${SEARCH_INPUT}    5s