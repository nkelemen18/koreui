<#import "koreui-template.ftl" as layout>
<@layout.loginLayout displayMessage=true; section>
    <#if section = "card-header">
        ${kcSanitize(msg("webauthn-error-title"))?no_esc}
    <#elseif section = "form">

        <script type="text/javascript" xmlns="http://www.w3.org/1999/html">
            refreshPage = () => {
                document.getElementById('isSetRetry').value = 'retry';
                document.getElementById('executionValue').value = '${execution}';
                document.getElementById('kc-error-credential-form').submit();
            }
        </script>

        <form id="kc-error-credential-form" action="${url.loginAction}" method="post">
            <input type="hidden" id="executionValue" name="authenticationExecution"/>
            <input type="hidden" id="isSetRetry" name="isSetRetry"/>
        </form>

        <div class="d-grid>">
            <button tabindex="1" onclick="refreshPage()" class="btn btn-primary mb-2" id="kc-try-again">
                ${kcSanitize(msg("doTryAgain"))?no_esc}
            </button>
        </div>
        <#if isAppInitiatedAction??>
            <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-webauthn-settings-form"
                  method="post">
                <div class="d-grid>">
                    <button type="submit" class="btn btn-light" id="cancelWebAuthnAIA" name="cancel-aia" value="true">
                        ${msg("doCancel")}
                    </button>
                </div>
            </form>
        </#if>
    </#if>
</@layout.loginLayout>