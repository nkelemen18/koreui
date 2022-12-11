<#import "koreui-template.ftl" as template>
<@template.loginLayout ; section>
    <#if section = "card-header">
        ${kcSanitize(msg("webauthn-login-title"))?no_esc}
    <#elseif section = "form">
        <div id="kc-form-webauthn">
            <form id="webauth" action="${url.loginAction}" method="post">
                <input type="hidden" id="clientDataJSON" name="clientDataJSON"/>
                <input type="hidden" id="authenticatorData" name="authenticatorData"/>
                <input type="hidden" id="signature" name="signature"/>
                <input type="hidden" id="credentialId" name="credentialId"/>
                <input type="hidden" id="userHandle" name="userHandle"/>
                <input type="hidden" id="error" name="error"/>
            </form>

            <#if authenticators??>
                <form id="authn_select" class="${properties.kcFormClass!}">
                    <#list authenticators.authenticators as authenticator>
                        <input type="hidden" name="authn_use_chk" value="${authenticator.credentialId}"/>
                    </#list>
                </form>

                <#if shouldDisplayAuthenticators?? && shouldDisplayAuthenticators>
                    <#if authenticators.authenticators?size gt 1>
                        <p class="fs-5">${kcSanitize(msg("webauthn-available-authenticators"))?no_esc}</p>
                    </#if>

                    <div class="${properties.kcFormClass!}">
                        <#list authenticators.authenticators as authenticator>
                            <!-- TODO fix logo icon position -->
                            <!-- TODO use different icons -->
                            <div id="kc-webauthn-authenticator" class="row">
                                <div class="col-2 d-flex align-items-center">
                                    <i class="cil-devices fs-1"></i>
                                </div>
                                <div class="col-10">
                                    <div id="kc-webauthn-authenticator-label">
                                        ${kcSanitize(msg('${authenticator.label}'))?no_esc}
                                    </div>

                                    <#if authenticator.transports?? && authenticator.transports.displayNameProperties?has_content>
                                        <div id="kc-webauthn-authenticator-transport">
                                            <#list authenticator.transports.displayNameProperties as nameProperty>
                                                <span>${kcSanitize(msg('${nameProperty!}'))?no_esc}</span>
                                                <#if nameProperty?has_next>
                                                    <span>, </span>
                                                </#if>
                                            </#list>
                                        </div>
                                    </#if>

                                    <div class="text-muted">
                                        <span id="kc-webauthn-authenticator-created-label">
                                            ${kcSanitize(msg('webauthn-createdAt-label'))?no_esc}
                                        </span>
                                        <span id="kc-webauthn-authenticator-created">
                                            ${kcSanitize(authenticator.createdAt)?no_esc}
                                        </span>
                                    </div>
                                </div>
                                <div class="${properties.kcSelectAuthListItemFillClass!}"></div>
                            </div>
                        </#list>
                    </div>
                </#if>
            </#if>

            <div id="kc-form-buttons" class="d-grid">
                <button id="authenticateWebAuthnButton" onclick="webAuthnAuthenticate()" autofocus="autofocus"
                        class="btn btn-primary mb-2"/>
                ${kcSanitize(msg("webauthn-doAuthenticate"))}
                </button>
            </div>
        </div>


        <script type="text/javascript" src="${url.resourcesCommonPath}/node_modules/jquery/dist/jquery.min.js"></script>
        <script type="text/javascript" src="${url.resourcesPath}/js/base64url.js"></script>
        <script type="text/javascript">
            function webAuthnAuthenticate() {
                let isUserIdentified = ${isUserIdentified};
                if (!isUserIdentified) {
                    doAuthenticate([]);
                    return;
                }
                checkAllowCredentials();
            }

            function checkAllowCredentials() {
                let allowCredentials = [];
                let authn_use = document.forms['authn_select'].authn_use_chk;

                if (authn_use !== undefined) {
                    if (authn_use.length === undefined) {
                        allowCredentials.push({
                            id: base64url.decode(authn_use.value, {loose: true}),
                            type: 'public-key',
                        });
                    } else {
                        for (let i = 0; i < authn_use.length; i++) {
                            allowCredentials.push({
                                id: base64url.decode(authn_use[i].value, {loose: true}),
                                type: 'public-key',
                            });
                        }
                    }
                }
                doAuthenticate(allowCredentials);
            }


            function doAuthenticate(allowCredentials) {

                // Check if WebAuthn is supported by this browser
                if (!window.PublicKeyCredential) {
                    $("#error").val("${msg("webauthn-unsupported-browser-text")?no_esc}");
                    $("#webauth").submit();
                    return;
                }

                let challenge = "${challenge}";
                let userVerification = "${userVerification}";
                let rpId = "${rpId}";
                let publicKey = {
                    rpId: rpId,
                    challenge: base64url.decode(challenge, {loose: true})
                };

                let createTimeout = ${createTimeout};
                if (createTimeout !== 0) publicKey.timeout = createTimeout * 1000;

                if (allowCredentials.length) {
                    publicKey.allowCredentials = allowCredentials;
                }

                if (userVerification !== 'not specified') publicKey.userVerification = userVerification;

                navigator.credentials.get({publicKey})
                    .then((result) => {
                        window.result = result;

                        let clientDataJSON = result.response.clientDataJSON;
                        let authenticatorData = result.response.authenticatorData;
                        let signature = result.response.signature;

                        $("#clientDataJSON").val(base64url.encode(new Uint8Array(clientDataJSON), {pad: false}));
                        $("#authenticatorData").val(base64url.encode(new Uint8Array(authenticatorData), {pad: false}));
                        $("#signature").val(base64url.encode(new Uint8Array(signature), {pad: false}));
                        $("#credentialId").val(result.id);
                        if (result.response.userHandle) {
                            $("#userHandle").val(base64url.encode(new Uint8Array(result.response.userHandle), {pad: false}));
                        }
                        $("#webauth").submit();
                    })
                    .catch((err) => {
                        $("#error").val(err);
                        $("#webauth").submit();
                    })
                ;
            }

        </script>
    </#if>
</@template.loginLayout>