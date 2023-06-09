<#import "koreui-template.ftl" as layout>
<@layout.loginLayout displayMessage=!messagesPerField.existsError('password'); section>
    <#if section = "card-header">
        ${msg("doLogIn")}
    <#elseif section = "form">
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
                      method="post">

                    <div class="input-group mb-3">
                        <span class="input-group-text"><i class="icon cil-lock-locked"></i></span>
                        <input tabindex="1" id="password" name="password" type="password"
                               class="form-control <#if messagesPerField.existsError('password')>is-invalid</#if>"
                               placeholder="${msg("password")}" autocomplete="on" autofocus>

                        <#if messagesPerField.existsError('password')>
                            <div id="input-error-password" class="invalid-feedback">
                                ${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}
                            </div>
                        </#if>
                    </div>

                    <div id="kc-form-buttons" class="d-grid">
                        <button tabindex="2" name="login" id="kc-login" class="btn btn-primary px-4">
                            ${msg("doLogIn")}
                        </button>
                    </div>
                </form>

                <#if realm.resetPasswordAllowed>
                    <a tabindex="3" class="btn btn-link px-0" type="button"
                       href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                </#if>
            </div>
        </div>
    </#if>

</@layout.loginLayout>
