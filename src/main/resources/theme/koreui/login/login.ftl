<#import "koreui-template.ftl" as template>
<@template.loginLayout displayRequiredFields=false displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>

    <#if section = "header">
        <h3>${msg("loginTitle",(realm.displayName!''))}</h3>
    <#elseif section = "form">
        <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
              method="post">
            <#if !usernameHidden??>
                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="icon cil-user"></i></span>
                    <input tabindex="1" id="username" name="username" value="${(login.username!'')}"
                           class="form-control <#if messagesPerField.existsError('username','password')>is-invalid</#if>"
                           placeholder="<#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>"
                           type="text" autofocus/>


                    <#if messagesPerField.existsError('username','password')>
                        <div id="input-error"  class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                        </div>
                    </#if>
                </div>
            </#if>

            <div class="input-group mb-3">
                <span class="input-group-text"><i class="icon cil-lock-locked"></i></span>
                <input tabindex="2" name="password" type="password"
                       class="form-control <#if messagesPerField.existsError('username','password')>is-invalid</#if>"
                       placeholder="${msg("password")}">
            </div>

            <#if realm.rememberMe && !usernameHidden??>
                <div id="kc-form-options" class="form-check mb-3">
                    <input tabindex="3" class="form-check-input" type="checkbox" id="rememberMe"
                           name="rememberMe" <#if login.rememberMe??>checked</#if> />
                    <label class="form-check-label" for="rememberMe">${msg("rememberMe")}</label>
                </div>
            </#if>

            <input type="hidden" id="id-hidden-input" name="credentialId"
                   <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
            <div class="d-grid gap-2">
                <button tabindex="4" name="login" class="btn btn-primary px-4">${msg("doLogIn")}</button>
            </div>
        </form>
        <#if realm.resetPasswordAllowed>
            <a tabindex="5" class="btn btn-link px-0" type="button"
               href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
        </#if>

    <#elseif section == "social-providers">
        <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="row">
                <hr class="col-12 my-2">
                <div class="col-12 text-center">
                    <h4>${msg("identity-provider-login-label")}</h4>
                </div>

                <div class="row g-1 row-cols-<#if social.providers?size gt 3>2<#else>1</#if>">
                    <#list social.providers as p>
                        <div class="col d-grid">
                            <a id="social-${p.alias}" type="button" href="${p.loginUrl}"
                               class="btn btn-sm btn-outline-dark ">
                                <span class="${p.iconClasses} mr-2"></span> ${p.displayName!}
                            </a>
                        </div>
                    </#list>
                </div>
            </div>
        </#if>

    <#elseif section == "info">
        <div class="text-center">${msg("noAccount")} <a href="${url.registrationUrl}">${msg("doRegister")}</a></div>
    </#if>
</@template.loginLayout>
