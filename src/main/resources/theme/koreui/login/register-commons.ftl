<#macro termsAcceptance>
    <#if termsAcceptanceRequired??>
        <div class="input-group">
            ${msg("termsTitle")}
            <div id="kc-registration-terms-text" style="max-height: 100px; overflow-y: auto; overflow-x: hidden">
                ${kcSanitize(msg("termsText"))?no_esc}
            </div>
        </div>
        <div class="input-group">
            <div class="form-check mb-3">
                <input tabindex="3" type="checkbox" id="termsAccepted" name="termsAccepted"
                       class="form-check-input <#if messagesPerField.existsError('termsAccepted')>is-invalid</#if>"/>
                <label class="form-check-label" for="termsAccepted">${msg("acceptTerms")}</label>
            </div>
            <#if messagesPerField.existsError('termsAccepted')>
                <div id="input-error-terms-accepted" class="invalid-feedback">
                    ${kcSanitize(messagesPerField.get('termsAccepted'))?no_esc}
                </div>
            </#if>
        </div>
    </#if>
</#macro>
