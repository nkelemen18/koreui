<#import "koreui-template.ftl" as template>
<@template.loginLayout displayInfo=true; section>
    <#if section = "card-header">
        ${msg("emailVerifyTitle")}
    <#elseif section = "form">
        <p>${msg("emailVerifyInstruction1",user.email)}</p>
    <#elseif section = "info">
        <p class="text-center">
            ${msg("emailVerifyInstruction2")}
            <br/>
            <a href="${url.loginAction}">${msg("doClickHere")}</a> ${msg("emailVerifyInstruction3")}
        </p>
    </#if>
</@template.loginLayout>