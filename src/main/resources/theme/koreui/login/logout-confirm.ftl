<#-- @ftlvariable name="logoutConfirm" type="org.keycloak.forms.login.freemarker.model.LogoutConfirmBean" -->
<#import "koreui-template.ftl" as layout>
<@layout.loginLayout; section>
    <#if section = "card-header">
        ${msg("logoutConfirmTitle")}
    <#elseif section = "form">
        <p>${msg("logoutConfirmHeader")}</p>
        <form class="form-actions" action="${url.logoutConfirmAction}" method="POST">
            <input type="hidden" name="session_code" value="${logoutConfirm.code}">

            <div id="kc-form-buttons" class="input-group mb-3">
                <button name="confirmLogout" id="kc-logout" type="submit"
                        class="btn btn-primary">${msg("doLogout")}</button>
            </div>

        </form>

        <#if logoutConfirm.skipLink>
        <#else>
            <#if (client.baseUrl)?has_content>
                <p><a href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a></p>
            </#if>
        </#if>

    </#if>
</@layout.loginLayout>