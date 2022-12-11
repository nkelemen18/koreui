<#import "koreui-template.ftl" as template>
<@template.loginLayout displayMessage=!messagesPerField.existsError('username','email','firstName','lastName'); section>
    <#if section = "card-header">
        ${msg("loginProfileTitle")}
    <#elseif section = "form">
        <form id="kc-update-profile-form" action="${url.loginAction}" method="post">
            <#if user.editUsernameAllowed>
                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="icon cil-user"></i></span>
                    <input tabindex="1" id="username" name="username" value="${(user.username!'')}"
                           class="form-control <#if messagesPerField.existsError('username')>is-invalid</#if>"
                           placeholder="${msg("username")}" autocomplete="username" type="text"/>


                    <#if messagesPerField.existsError('username')>
                        <div class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}
                        </div>
                    </#if>
                </div>
            </#if>

            <#if user.editEmailAllowed>
                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="icon cil-at"></i></span>
                    <input tabindex="2" id="email" name="email" value="${(user.email!'')}"
                           class="form-control <#if messagesPerField.existsError('email')>is-invalid</#if>"
                           placeholder="${msg("email")}" autocomplete="email" type="text"/>


                    <#if messagesPerField.existsError('email')>
                        <div class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('email'))?no_esc}
                        </div>
                    </#if>
                </div>
            </#if>

            <div class="input-group mb-3">
                <span class="input-group-text"><i class="icon cil-baby"></i></span>
                <input tabindex="3" id="firstName" name="firstName" value="${(user.firstName!'')}"
                       class="form-control <#if messagesPerField.existsError('firstName')>is-invalid</#if>"
                       placeholder="${msg("firstName")}" autocomplete="given-name" type="text" autofocus/>


                <#if messagesPerField.existsError('firstName')>
                    <div class="invalid-feedback">
                        ${kcSanitize(messagesPerField.getFirstError('firstName'))?no_esc}
                    </div>
                </#if>
            </div>


            <div class="input-group mb-3">
                <span class="input-group-text"><i class="icon cil-people"></i></span>
                <input tabindex="4" id="lastName" name="lastName" value="${(user.lastName!'')}"
                       class="form-control <#if messagesPerField.existsError('lastName')>is-invalid</#if>"
                       placeholder="${msg("lastName")}" autocomplete="family-name" type="text"/>


                <#if messagesPerField.existsError('lastName')>
                    <div class="invalid-feedback">
                        ${kcSanitize(messagesPerField.getFirstError('lastName'))?no_esc}
                    </div>
                </#if>
            </div>


            <div class="d-grid gap-2">
                <button tabindex="5" type="submit" id="savePasswordBtn"
                        class="btn btn-primary px-4">${msg("doSubmit")}</button>
                <#if isAppInitiatedAction??>
                    <button tabindex="6" type="submit" id="cancelTOTPBtn" name="cancel-aia" value="true"
                            class="btn btn-light px-4">${msg("doCancel")}</button>
                </#if>
            </div>
        </form>
    </#if>
</@template.loginLayout>