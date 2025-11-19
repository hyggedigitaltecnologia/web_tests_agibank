*** Settings ***
Resource    ../main.robot
Resource    ../helpers/dependencies.robot

*** Keywords ***
Click Element Via Js
    [Arguments]    ${locator}
    ${element}=    Get WebElement    ${locator}
    Execute Javascript    arguments[0].click();    ${element}