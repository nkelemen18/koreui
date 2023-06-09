<#import "koreui-template.ftl" as layout>
<@layout.loginLayout displayCardHeader=true; section>
    <#if section = "card-header">
        ${msg("oauth2DeviceVerificationTitle")}
    <#elseif section = "form">
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <form id="kc-user-verify-device-user-code-form" action="${url.oauth2DeviceVerificationAction}"
                      method="post">
                    <label for="device-user-code"
                           class="form-label">${msg("verifyOAuth2DeviceUserCode")}</label>
                    <div class="input-group mb-3">
                        <span class="input-group-text"><i class="icon cil-devices"></i></span>
                        <input tabindex="1" id="device-user-code" autofocus name="device_user_code" class="form-control"
                               autocomplete="off" type="text"/>
                    </div>

                    <div class="d-grid gap-2">
                        <button tabindex="2" class="btn btn-primary px-4" type="submit">${msg("doSubmit")}</button>
                    </div>

                </form>
            </div>
        </div>
    </#if>
</@layout.loginLayout>