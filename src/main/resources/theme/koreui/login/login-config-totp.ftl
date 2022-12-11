<#import "koreui-template.ftl" as template>
<@template.loginLayout displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>

    <#if section = "card-header">
        ${msg("loginTotpTitle")}
    <#elseif section = "form">
        <ol>
            <li>
                <p>${msg("loginTotpStep1")}</p>

                <ul>
                    <#list totp.supportedApplications as app>
                        <li>${msg(app)}</li>
                    </#list>
                </ul>
            </li>


            <#if mode?? && mode = "manual">
                <li>
                    <p>${msg("loginTotpManualStep2")}</p>
                    <p class="text-center fw-bold"><span id="kc-totp-secret-key">${totp.totpSecretEncoded}</span></p>
                    <p class="text-center">
                        <a href="${totp.qrUrl}" id="mode-barcode">${msg("loginTotpScanBarcode")}</a>
                    </p>
                </li>
                <li>
                    <p>${msg("loginTotpManualStep3")}</p>
                    <p>
                    <ul>
                        <li id="kc-totp-type">${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}</li>
                        <li id="kc-totp-algorithm">${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                        <li id="kc-totp-digits">${msg("loginTotpDigits")}: ${totp.policy.digits}</li>
                        <#if totp.policy.type = "totp">
                            <li id="kc-totp-period">${msg("loginTotpInterval")}: ${totp.policy.period}</li>
                        <#elseif totp.policy.type = "hotp">
                            <li id="kc-totp-counter">${msg("loginTotpCounter")}: ${totp.policy.initialCounter}</li>
                        </#if>
                    </ul>
                    </p>
                </li>
            <#else>
                <li>
                    <p>${msg("loginTotpStep2")}</p>
                    <div class="text-center">
                        <img id="kc-totp-secret-qr-code" style="width: 150px; height: 150px;"
                             src="data:image/png;base64, ${totp.totpSecretQrCode}"
                             alt="Figure: Barcode"><br/>
                    </div>
                    <p class="text-center">
                        <a href="${totp.manualUrl}" id="mode-manual">${msg("loginTotpUnableToScan")}</a>
                    </p>
                </li>
            </#if>
            <li>
                <p>${msg("loginTotpStep3")}</p>
                <p>${msg("loginTotpStep3DeviceName")}</p>
            </li>
        </ol>

        <form action="${url.loginAction}" id="kc-totp-settings-form" method="post">
            <div class="input-group mb-3">
                <span class="input-group-text"><i class="icon cil-qr-code"></i></span>
                <input tabindex="1" id="totp" name="totp"
                       class="form-control <#if messagesPerField.existsError('totp')>is-invalid</#if>"
                       placeholder="${msg("authenticatorCode")}" type="text" autocomplete="off" autofocus/>


                <#if messagesPerField.existsError('totp')>
                    <div class="invalid-feedback">
                        ${kcSanitize(messagesPerField.getFirstError('totp'))?no_esc}
                    </div>
                </#if>
            </div>

            <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}"/>
            <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>

            <div class="input-group mb-3">
                <span class="input-group-text"><i class="icon cil-tag"></i></span>
                <input tabindex="2" id="userLabel" name="userLabel"
                       class="form-control <#if messagesPerField.existsError('userLabel')>is-invalid</#if>"
                       placeholder="${msg("loginTotpDeviceName")}" type="text" autocomplete="off"/>


                <#if messagesPerField.existsError('userLabel')>
                    <div class="invalid-feedback">
                        ${kcSanitize(messagesPerField.getFirstError('userLabel'))?no_esc}
                    </div>
                </#if>
            </div>

            <div class="d-grid gap-2">
                <button tabindex="3" type="submit" id="saveTOTPBtn"
                        class="btn btn-primary px-4">${msg("doSubmit")}</button>
                <#if isAppInitiatedAction??>
                    <button tabindex="4" type="submit" id="cancelTOTPBtn" name="cancel-aia" value="true"
                            class="btn btn-light px-4">${msg("doCancel")}</button>
                </#if>
            </div>

        </form>

    </#if>

</@template.loginLayout>