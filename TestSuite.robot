*** Settings ***
Suite Setup       open browser    https://www.imdb.com/    firefox
Library           SeleniumLibrary
Library           String
Library           Collections

*** Variables ***
${Movie}          The Shawshank Redemption
${SearchButton}    suggestion-search-button
@{Elements}
@{Elems}












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
    ${element}    Get WebElement    class=ipc-btn__text
    Click Element    ${element}
    Click link    https://www.imdb.com/search/?ref_=nv_sr_menu_adv
    click link    /search/title
    click element    id=title_type-1
    click element    id=genres-1
    input text    name=release_date-min    2010
    input text    name=release_date-max    2020
    click button    class=primary
    sleep    1
    click link    /search/title/?title_type=feature&release_date=2010-01-01,2020-12-31&genres=action&sort=user_rating,desc
    @{elements}=    Get WebElements    class=lister-item-year
    FOR    ${element}    IN    @{elements}
    ${stringElement}=    Get Text    ${element}
    ${stringElement}=    Get SubString    ${stringElement}    -5    -1
    ${stringElement}=    convert to number    ${stringElement}
    IF    2020 < ${stringElement} < 2010
    fail
    END
    END
    ${ratings}=    Create List
    @{Elems}=    Get WebElements    class=ratings-imdb-rating
    FOR    ${element}    IN    @{Elems}
    ${stringElement}=    Get Text    ${element}
    ${stringElement}=    convert to number    ${stringElement}
    append to list    ${ratings}    ${stringElement}
    END
    ${ratingsCopy}=    Copy List    ${ratings}
    Sort List    ${ratings}
    reverse List    ${ratings}
    Lists should be Equal    ${ratings}    ${ratingsCopy}
