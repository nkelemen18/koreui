<#import "koreui-template.ftl" as template>
<@template.loginLayout displayInfo=true displayCardHeader=true; section>
    <#if section = "card-header">
        ${msg("emailForgotTitle")}
    <#elseif section = "form">
        <form action="${url.loginAction}" method="post">

            <div class="input-group mb-3">
                <span class="input-group-text"><i class="icon cil-user"></i></span>
                <input tabindex="1" autofocus name="username" value="${(auth.attemptedUsername!'')}"
                       class="form-control <#if messagesPerField.existsError('username')>is-invalid</#if>"
                       placeholder="<#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>"
                       type="text"/>

                <#if messagesPerField.existsError('username')>
                    <div id="input-error-username" class="invalid-feedback">
                        ${kcSanitize(messagesPerField.get('username'))?no_esc}
                    </div>
                </#if>

            </div>

            <div class="d-grid gap-2">
                <button tabindex="2" name="login" class="btn btn-primary px-4" type="submit">${msg("doSubmit")}</button>
            </div>
        </form>

        <a class="btn btn-link px-0" href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a>
    <#elseif section = "info" >
        <div class="text-center">
            <#if realm.duplicateEmailsAllowed>
                ${msg("emailInstructionUsername")}
            <#else>
                ${msg("emailInstruction")}
            </#if>
        </div>
    </#if>

</@template.loginLayout>