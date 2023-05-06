*** Settings ***
Suite Setup       open browser    https://www.imdb.com/    firefox
Library           SeleniumLibrary

*** Variables ***
${Movie}          The Shawshank Redemption
${SearchButton}    suggestion-search-button
@{Elements}


*** Test Cases ***
Scenario1
    input text    id=suggestion-search    ${Movie}
    click button    ${SearchButton}
    Page Should Contain Link    /title/tt0111161/?ref_=fn_al_tt_1

Scenario2
    click element    id=imdbHeader-navDrawerOpen
    click link    /chart/top/?ref_=nv_mv_250
    ${id}=    Get Element Attribute    tag=table    data-caller-name
    Should Be Equal As Strings    ${id}    chart-top250movie
    ${className}=    Get WebElement    class=titleColumn
    ${ranking}=    Get Text    ${className}
    Should Be Equal As Strings    ${ranking}    1. The Shawshank Redemption (1994)

Scenario3
    ${element}      Get WebElement      class=ipc-btn__text
    Click Element   ${element}    
    @{elements}=    Get WebElement    class=ipc-btn__text
    Click Element    ${elements}
