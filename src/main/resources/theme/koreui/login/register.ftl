<#import "koreui-template.ftl" as template>
<#import "register-commons.ftl" as registerCommons>
<@template.loginLayout ; section>
    <#if section = "card-header">
        ${msg("registerTitle")}
    <#elseif section = "form">
        <form id="kc-register-form" action="${url.registrationAction}" method="post">

            <div class="input-group mb-3">
                <span class="input-group-text"><i class="icon cil-baby"></i></span>
                <input id="firstName" name="firstName" value="${(register.formData.firstName!'')}"
                       class="form-control <#if messagesPerField.existsError('firstName')>is-invalid</#if>"
                       placeholder="${msg("firstName")}" autocomplete="given-name" type="text" autofocus/>


                <#if messagesPerField.existsError('firstName')>
                    <div id="input-error-firstname" class="invalid-feedback">
                        ${kcSanitize(messagesPerField.getFirstError('firstName'))?no_esc}
                    </div>
                </#if>
            </div>


            <div class="input-group mb-3">
                <span class="input-group-text"><i class="icon cil-people"></i></span>
                <input id="lastName" name="lastName" value="${(register.formData.lastName!'')}"
                       class="form-control <#if messagesPerField.existsError('lastName')>is-invalid</#if>"
                       placeholder="${msg("lastName")}" autocomplete="family-name" type="text"/>


                <#if messagesPerField.existsError('lastName')>
                    <div id="input-error-lastname" class="invalid-feedback">
                        ${kcSanitize(messagesPerField.getFirstError('lastName'))?no_esc}
                    </div>
                </#if>
            </div>

            <div class="input-group mb-3">
                <span class="input-group-text"><i class="icon cil-at"></i></span>
                <input id="email" name="email" value="${(register.formData.email!'')}"
                       class="form-control <#if messagesPerField.existsError('email')>is-invalid</#if>"
                       placeholder="${msg("email")}" autocomplete="email" type="text"/>


                <#if messagesPerField.existsError('email')>
                    <div id="input-error-email" class="invalid-feedback">
                        ${kcSanitize(messagesPerField.getFirstError('email'))?no_esc}
                    </div>
                </#if>
            </div>


            <#if !realm.registrationEmailAsUsername>
                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="icon cil-user"></i></span>
                    <input id="username" name="username" value="${(register.formData.username!'')}"
                           class="form-control <#if messagesPerField.existsError('username')>is-invalid</#if>"
                           placeholder="${msg("username")}" autocomplete="username" type="text"/>


                    <#if messagesPerField.existsError('username')>
                        <div id="input-error-username" class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}
                        </div>
                    </#if>
                </div>
            </#if>

            <#if passwordRequired??>
                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="icon cil-lock-locked"></i></span>
                    <input id="password" name="password"
                           class="form-control <#if messagesPerField.existsError('password', 'password-confirm')>is-invalid</#if>"
                           placeholder="${msg("password")}" autocomplete="new-password" type="password"/>


                    <#if messagesPerField.existsError('password')>
                        <div id="input-error-password" class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}
                        </div>
                    </#if>
                </div>

                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="icon cil-lock-locked"></i></span>
                    <input id="password-confirm" name="password-confirm"
                           class="form-control <#if messagesPerField.existsError('password-confirm')>is-invalid</#if>"
                           placeholder="${msg("passwordConfirm")}" type="password"/>


                    <#if messagesPerField.existsError('password-confirm')>
                        <div id="input-error-password-confirm" class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('password-confirm'))?no_esc}
                        </div>
                    </#if>
                </div>
            </#if>

            <@registerCommons.termsAcceptance/>

            <#if recaptchaRequired??>
                <div class="input-group mb-3">
                    <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                </div>
            </#if>

            <div id="kc-form-buttons" class="d-grid gap-2">
                <button type="submit" class="btn btn-success px-4">${msg("doRegister")}</button>
            </div>

        </form>

        <a class="btn btn-link px-0" href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a>


    </#if>
</@template.loginLayout>
