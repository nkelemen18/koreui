<#import "koreui-template.ftl" as layout>
<@layout.loginLayout displayMessage=!messagesPerField.existsError('username') displayInfo=(realm.password && realm.registrationAllowed && !registrationDisabled??); section>
    <#if section = "header">
        <h3> ${msg("loginAccountTitle")}</h3>
    <#elseif section = "form">
        <#if realm.password>
            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
                  method="post">
                <#if !usernameHidden??>

                    <div class="input-group mb-3">
                        <span class="input-group-text"><i class="icon cil-user"></i></span>
                        <input tabindex="1" id="username" name="username" value="${(login.username!'')}"
                               class="form-control <#if messagesPerField.existsError('username')>is-invalid</#if>"
                               placeholder="<#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>"
                               type="text" autofocus/>


                        <#if messagesPerField.existsError('username')>
                            <div class="invalid-feedback">
                                ${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}
                            </div>
                        </#if>
                    </div>
                </#if>

                <#if realm.rememberMe && !usernameHidden??>
                    <div class="form-check mb-3">
                        <input tabindex="2" class="form-check-input" type="checkbox" id="rememberMe"
                               name="rememberMe" <#if login.rememberMe??>checked</#if> />
                        <label class="form-check-label" for="rememberMe">${msg("rememberMe")}</label>
                    </div>
                </#if>

                <div class="d-grid gap-2">
                    <button tabindex="3" name="login" id="kc-login"
                            class="btn btn-primary px-4">${msg("doLogIn")}</button>
                </div>
            </form>

        </#if>
    <#elseif section = "info">
        <div class="text-center">
            ${msg("noAccount")} <a href="${url.registrationUrl}" tabindex="4">${msg("doRegister")}</a>
        </div>
    <#elseif section="social-providers">
        <#if realm.password && social.providers??>
            <div class="row">
                <div class="col-12 text-center">
                    <h4>${msg("identity-provider-login-label")}</h4>
                </div>

                <div class="row g-1 row-cols-<#if social.providers?size gt 3>2<#else>1</#if>">
                    <#list social.providers as p>
                        <div class="col d-grid">
                            <a type="button" href="${p.loginUrl}" class="btn btn-sm btn-outline-dark ">
                                <span class="cib-${p.alias} mr-2"></span> ${p.displayName!}
                            </a>
                        </div>
                    </#list>
                </div>
            </div>
        </#if>
    </#if>

</@layout.loginLayout>
