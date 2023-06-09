<#import "koreui-template.ftl" as layout>
<@layout.loginLayout displayInfo=false; section>
    <#if section = "header">
        <h3 class="text-center">${msg("loginChooseAuthenticator")}</h3>
    <#elseif section = "form">
        <form id="kc-select-credential-form" action="${url.loginAction}" method="post">
            <div class="list-group list-group-flush">
                <#list auth.authenticationSelections as authenticationSelection>

                    <button class="list-group-item list-group-item-action" name="authenticationExecution"
                            value="${authenticationSelection.authExecId}">
                        <div class="d-flex align-items-center">
                            <span class="me-3 icon icon-xxl ${properties['${authenticationSelection.iconCssClass}']!authenticationSelection.iconCssClass}"></span>
                            <div>
                                <h5 class="mb-1">${msg('${authenticationSelection.displayName}')}</h5>
                                <small>${msg('${authenticationSelection.helpText}')}</small>
                            </div>
                        </div>
                    </button>
                </#list>
                <input type="hidden" id="authexec-hidden-input" name="authenticationExecution" />
            </div>
        </form>
    </#if>
</@layout.loginLayout>
