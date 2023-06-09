<#import "koreui-template.ftl" as layout>
<@layout.loginLayout displayCardHeader=true displayMessage=false; section>
    <#if section = "card-header">
        ${kcSanitize(msg("errorTitle"))?no_esc}
    <#elseif section = "form">
        <div id="kc-error-message">
            <p class="m-0 mb-2">${kcSanitize(message.summary)?no_esc}</p>
            <#if skipLink??>
            <#else>
                <#if client?? && client.baseUrl?has_content>
                    <p class="mt-2 mb-0"><a id="backToApplication"
                                            href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a>
                    </p>
                </#if>
            </#if>
        </div>
    </#if>
</@layout.loginLayout>