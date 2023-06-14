<#import "koreui-template.ftl" as layout>
<@layout.loginLayout displayMessage=false; section>
    <#if section = "card-header">
        ${msg("saml.post-form.title")}
    <#elseif section = "form">
        <p>${msg("saml.post-form.message")}</p>
        <form name="saml-post-binding" method="post" action="${samlPost.url}">
            <#if samlPost.SAMLRequest??>
                <input type="hidden" name="SAMLRequest" value="${samlPost.SAMLRequest}"/>
            </#if>
            <#if samlPost.SAMLResponse??>
                <input type="hidden" name="SAMLResponse" value="${samlPost.SAMLResponse}"/>
            </#if>
            <#if samlPost.relayState??>
                <input type="hidden" name="RelayState" value="${samlPost.relayState}"/>
            </#if>

            <noscript>
                <p>${msg("saml.post-form.js-disabled")}</p>
                <button tabindex="1" type="submit" class="btn btn-success">${msg("doContinue")}</button>
            </noscript>
        </form>
        <script>window.onload = function () {document.forms[0].submit()};</script>
    </#if>
</@layout.loginLayout>