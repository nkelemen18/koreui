<#import "koreui-template.ftl" as template>
<#import "password-commons.ftl" as passwordCommons>
<@template.loginLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
    <#if section = "card-header">
        ${msg("updatePasswordTitle")}
    <#elseif section = "form">
        <form id="kc-passwd-update-form" action="${url.loginAction}" method="post">
            <input type="hidden" id="username" name="username" value="${username}" autocomplete="username"
                   readonly="readonly"/>
            <input type="password" id="password" name="password" autocomplete="current-password" class="d-none"/>



            <div class="input-group mb-3">
                <span class="input-group-text"><i class="icon cil-lock-locked"></i></span>
                <input tabindex="1" id="password-new" name="password-new"
                       class="form-control <#if messagesPerField.existsError('password','password-confirm')>is-invalid</#if>"
                       placeholder="${msg("passwordNew")}" autocomplete="new-password" autofocus type="password"/>


                <#if messagesPerField.existsError('password')>
                    <div id="input-error-password" class="invalid-feedback">
                        ${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}
                    </div>
                </#if>
            </div>

            <div class="input-group mb-3">
                <span class="input-group-text"><i class="icon cil-lock-locked"></i></span>
                <input tabindex="2" id="password-confirm" name="password-confirm"
                       class="form-control <#if messagesPerField.existsError('password-confirm')>is-invalid</#if>"
                       placeholder="${msg("passwordConfirm")}" autocomplete="new-password" type="password"/>


                <#if messagesPerField.existsError('password-confirm')>
                    <div id="input-error-password-confirm" class="invalid-feedback">
                        ${kcSanitize(messagesPerField.getFirstError('password-confirm'))?no_esc}
                    </div>
                </#if>
            </div>

            <@passwordCommons.logoutOtherSessions/>

            <div class="d-grid gap-2">
                <button tabindex="4" type="submit" id="savePasswordBtn"
                        class="btn btn-primary px-4">${msg("doSubmit")}</button>
                <#if isAppInitiatedAction??>
                    <button tabindex="5" type="submit" id="cancelTOTPBtn" name="cancel-aia" value="true"
                            class="btn btn-light px-4">${msg("doCancel")}</button>
                </#if>
            </div>

        </form>
    </#if>
</@template.loginLayout>