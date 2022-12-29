<#macro loginLayout displayInfo=false displayHeader=false displayMessage=true displayRequiredFields=false>
    <!doctype html>
    <html lang="en">
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
        <link rel="stylesheet" href="${url.resourcesPath}/css/coreui.css">
        <link rel="stylesheet" href="${url.resourcesPath}/css/koreui.css">
        <link rel="stylesheet" href="${url.resourcesPath}/node_modules/@coreui/icons/css/free.min.css">
        <link rel="stylesheet" href="${url.resourcesPath}/node_modules/@coreui/icons/css/brand.min.css">
    </head>
    <body>
    <div class="bg-light min-vh-100 d-flex flex-row align-items-center">
        <div class="container">
            <div class="row justify-content-center">
                <div id="kc-header" class="col-12 text-center">
                    <div id="kc-header-wrapper"
                         class="${properties.kcHeaderWrapperClass!}">${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}</div>
                </div>
                <div class="card col-md-8 col-xl-6 col-xxl-5 p-0 mb-0">
                    <#if displayHeader || realm.internationalizationEnabled && locale.supported?size gt 1>
                        <div class="card-header px-4">
                            <div class="row">
                                <div class="col p-0 d-flex align-items-center">
                                    <#nested "card-header">
                                </div>
                                <#if realm.internationalizationEnabled && locale.supported?size gt 1>
                                    <div class="col-3 col-xs-2 p-0 text-end">
                                        <div class="dropdown">
                                            <a class="btn btn-sm btn-ghost dropdown-toggle" href="#" role="button"
                                               data-coreui-toggle="dropdown">
                                                ${locale.current}
                                            </a>

                                            <ul class="dropdown-menu">
                                                <#list locale.supported as l>
                                                    <#if locale.currentLanguageTag == l.languageTag>
                                                        <li><a class="dropdown-item disabled" href="#">${l.label}</a>
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
                    <div class="card-body px-4 pt-3 py-2">
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
                        <div class="card-footer px-4">
                            <#nested "info">
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>
    <script src="${url.resourcesPath}/node_modules/@coreui/coreui/dist/js//coreui.bundle.min.js"></script>
    <script>
        (() => {
            const tooltipTriggerList = document.querySelectorAll('[data-coreui-toggle="tooltip"]');
            const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new coreui.Tooltip(tooltipTriggerEl));
        })();
    </script>
    </body>
    </html>
</#macro>
