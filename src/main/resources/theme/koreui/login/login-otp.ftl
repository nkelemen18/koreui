<#import "koreui-template.ftl" as template>
<@template.loginLayout displayMessage=!messagesPerField.existsError('totp'); section>
    <#if section="card-header">
        ${msg("doLogIn")}
    <#elseif section="form">
        <form id="kc-otp-login-form" action="${url.loginAction}" method="post">

            <!-- TODO credentials -->
            <div class="input-group mb-3">
                <span class="input-group-text"><i class="icon cil-lock-unlocked"></i></span>
                <input id="otp" name="otp" autofocus autocomplete="one-time-code" type="text"
                       class="form-control <#if messagesPerField.existsError('totp')>is-invalid</#if>"
                       placeholder="${msg("loginOtpOneTime")}"/>


                <#if messagesPerField.existsError('totp')>
                    <div class="invalid-feedback">
                        ${kcSanitize(messagesPerField.getFirstError('totp'))?no_esc}
                    </div>
                </#if>
            </div>

            <div class="d-grid mb-2">
                <button name="login" id="kc-login" type="submit" class="btn btn-primary px-4">${msg("doLogIn")}</button>
            </div>


        </form>
    </#if>
</@template.loginLayout>