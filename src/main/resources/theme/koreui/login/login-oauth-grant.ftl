<#import "koreui-template.ftl" as template>
<@template.loginLayout ; section>
    <#if section = "card-header">
        <#if client.name?has_content>
            ${msg("oauthGrantTitle",advancedMsg(client.name))}
        <#else>
            ${msg("oauthGrantTitle",client.clientId)}
        </#if>
    <#elseif section = "form">
        <#if client.attributes.logoUri??>
            <img src="${client.attributes.logoUri}"/>
        </#if>
        <h3>${msg("oauthGrantRequest")}</h3>

        <ul>
            <#if oauth.clientScopesRequested??>
                <#list oauth.clientScopesRequested as clientScope>
                    <li>
                        <#if !clientScope.dynamicScopeParameter??>
                            ${advancedMsg(clientScope.consentScreenText)}
                        <#else>
                            ${advancedMsg(clientScope.consentScreenText)}:
                            <b>${clientScope.dynamicScopeParameter}</b>
                        </#if>
                    </li>
                </#list>
            </#if>
        </ul>

        <#if client.attributes.policyUri?? || client.attributes.tosUri??>
            <h5>
                <#if client.name?has_content>
                    ${msg("oauthGrantInformation",advancedMsg(client.name))}
                <#else>
                    ${msg("oauthGrantInformation",client.clientId)}
                </#if>
            </h5>
            <#if client.attributes.tosUri??>
                <p>
                    ${msg("oauthGrantReview")}
                    <a href="${client.attributes.tosUri}" target="_blank">${msg("oauthGrantTos")}</a>
                </p>
            </#if>
            <#if client.attributes.policyUri??>
                <p>
                    ${msg("oauthGrantReview")}
                    <a href="${client.attributes.policyUri}" target="_blank">${msg("oauthGrantPolicy")}</a>
                </p>
            </#if>

        </#if>

        <form class="form-actions" action="${url.oauthAction}" method="POST">
            <input type="hidden" name="code" value="${oauth.code}">


            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary" name="accept" id="updateProfile">${msg("doYes")}</button>
                <button type="submit" class="btn btn-light" name="cancel" id="linkAccount">${msg("doNo")}</button>
            </div>

        </form>

    </#if>
</@template.loginLayout>