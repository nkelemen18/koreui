<#macro loginLayout displayInfo=false displayCardHeader=false displayMessage=true displayRequiredFields=false>
    <#assign themeVariant = properties.theme_variant!'light'/>
    <!doctype html>
    <html <#if realm.internationalizationEnabled> lang="${locale.currentLanguageTag}"<#else> lang="en"</#if>>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="robots" content="noindex, nofollow">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <#if properties.meta?has_content>
            <#list properties.meta?split(' ') as meta>
                <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
            </#list>
        </#if>

        <title>${msg("loginTitle",(realm.displayName!''))}</title>
        <link rel="icon" href="${url.resourcesPath}/img/favicon.ico"/>
        <link rel="stylesheet" href="${url.resourcesPath}/css/style.css">
        <#if themeVariant == "dark">
            <link rel="stylesheet" href="${url.resourcesPath}/css/dark.css">
        </#if>
        <link rel="stylesheet" href="${url.resourcesPath}/vendor/css/free.min.css">
        <link rel="stylesheet" href="${url.resourcesPath}/vendor/css/brand.min.css">
    </head>
    <body class="<#if themeVariant == "dark">dark-theme</#if>">
    <div class="min-vh-100 d-flex flex-row align-items-center <#if themeVariant == "light">bg-light</#if>">
        <div class="container">
            <div class="row justify-content-center">
                <div id="kc-header" class="col-12 text-center">
                    <div id="kc-header-wrapper"
                         class="${properties.kcHeaderWrapperClass!}">${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}</div>
                </div>
                <div id="kc-content" class="card col-md-8 col-xl-6 col-xxl-5 p-0 mb-0">
                    <#if displayCardHeader || realm.internationalizationEnabled && locale.supported?size gt 1>
                        <div class="card-header px-4">
                            <div class="row">
                                <div class="col p-0 d-flex align-items-center">
                                    <#nested "card-header">
                                </div>
                                <#if realm.internationalizationEnabled && locale.supported?size gt 1>
                                    <div id="kc-locale" class="col-3 col-xs-2 p-0 text-end">
                                        <div id="kc-locale-wrapper" class="dropdown">
                                            <a id="kc-current-locale-link" class="btn btn-sm btn-ghost dropdown-toggle"
                                               href="#" role="button" data-coreui-toggle="dropdown">
                                                ${locale.current}
                                            </a>

                                            <ul id="kc-locale-dropdown" class="dropdown-menu">
                                                <#list locale.supported as l>
                                                    <#if locale.currentLanguageTag == l.languageTag>
                                                        <li><a id="kc-current-locale-link"
                                                               class="dropdown-item disabled" href="#">${l.label}</a>
                                                        </li>
                                                    <#else >
                                                        <li><a class="dropdown-item" href="${l.url}">${l.label}</a></li>
                                                    </#if>
                                                </#list>
                                            </ul>
                                        </div>
                                    </div>
                                </#if>
                            </div>
                        </div>
                    </#if>
                    <div id="kc-content-wrapper" class="card-body px-4 pt-3 py-2">
                        <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                            <div class="alert alert-<#if message.type = 'error'>danger<#else>${message.type}</#if>"
                                 role="alert">
                                <!-- TODO alert icon -->
                                <div>${kcSanitize(message.summary)?no_esc}</div>
                            </div>
                        </#if>

                        <#if (auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
                            <#nested "show-username">
                            <div id="kc-username" class="text-center mb-4">
                                <span id="kc-attempted-username" class="fs-3">${auth.attemptedUsername}</span>
                                <a id="reset-login" href="${url.loginRestartFlowUrl}"
                                   data-coreui-toggle="tooltip" data-coreui-placement="top"
                                   title="${msg("restartLoginTooltip")}"
                                   aria-label="${msg("restartLoginTooltip")}">
                                    <i class="icon cil-reload icon-custom-size fs-4"></i>
                                </a>
                            </div>
                        </#if>

                        <#nested "header">

                        <#if displayRequiredFields>
                            <div><span class="text-danger">*</span> ${msg("requiredFields")}</div>
                        </#if>

                        <#nested "form">

                        <#if auth?has_content && auth.showTryAnotherWayLink()>
                            <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                                <input type="hidden" name="tryAnotherWay" value="on"/>
                                <button type="submit" class="btn btn-link px-0" id="try-another-way">
                                    ${msg("doTryAnotherWay")}
                                </button>
                            </form>
                        </#if>

                        <#nested "social-providers">

                    </div>
                    <#if displayInfo>
                        <div id="kc-info-wrapper" class="card-footer px-4">
                            <#nested "info">
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>
    <script src="${url.resourcesPath}/vendor/js/coreui.bundle.min.js"></script>
    <script>
        (() => {
            const tooltipTriggerList = document.querySelectorAll('[data-coreui-toggle="tooltip"]');
            const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new coreui.Tooltip(tooltipTriggerEl));
        })();
    </script>
    </body>
    </html>
</#macro>
