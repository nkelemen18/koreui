<#import "koreui-template.ftl" as layout>
<@layout.loginLayout; section>
    <#if section = "card-header">
        ${msg("pageExpiredTitle")}
    <#elseif section = "form">
        <p>
            ${msg("pageExpiredMsg1")} <a id="loginRestartLink" href="${url.loginRestartFlowUrl}">${msg("doClickHere")}</a> .<br/>
            ${msg("pageExpiredMsg2")} <a id="loginContinueLink" href="${url.loginAction}">${msg("doClickHere")}</a> .
        </p>
    </#if>
</@layout.loginLayout>
