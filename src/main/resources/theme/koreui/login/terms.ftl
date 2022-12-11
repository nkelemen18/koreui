<#import "koreui-template.ftl" as layout>
<@layout.loginLayout displayMessage=false; section>
    <#if section = "card-header">
        ${msg("termsTitle")}
    <#elseif section = "form">
        <div id="kc-terms-text">
            ${kcSanitize(msg("termsText"))?no_esc}
        </div>
        <form class="form-actions" action="${url.loginAction}" method="POST">
            <button tabindex="1" name="accept" id="kc-accept" type="submit"
                    class="btn btn-success">${msg("doAccept")}</button>
            <button tabindex="2" name="cancel" id="kc-decline" type="submit"
                    class="btn btn-danger">${msg("doDecline")}</button>
        </form>
        <div class="clearfix"></div>
    </#if>
</@layout.loginLayout>
