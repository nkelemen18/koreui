<#import "koreui-template.ftl" as layout>
<@layout.loginLayout; section>

    <#if section = "card-header">
        ${msg("deleteAccountConfirm")}
    <#elseif section = "form">
        <div class="alert alert-warning" role="alert">
            <!-- TODO icon -->
            ${msg("irreversibleAction")}
        </div>

        <p>${msg("deletingImplies")}</p>
        <ul class="text-dark">
            <li>${msg("loggingOutImmediately")}</li>
            <li>${msg("errasingData")}</li>
        </ul>

        <p class="text-danger">${msg("finalDeletionConfirmation")}</p>


        <form action="${url.loginAction}" method="post">
            <div class="row">
                <div class="col">
                    <button type="submit" class="btn btn-danger">${msg("doConfirmDelete")}</button>
                </div>
                <#if triggered_from_aia>
                    <div class="col text-end">
                        <button type="submit" name="cancel-aia" value="true"
                                class="btn btn-light">${msg("doDecline")}</button>
                    </div>
                </#if>
            </div>
        </form>
    </#if>
</@layout.loginLayout>