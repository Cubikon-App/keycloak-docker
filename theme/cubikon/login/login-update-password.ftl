<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>

    <#if section = "header">
        ${msg("updatePasswordTitle")}

    <#elseif section = "form">
        <form action="${url.loginAction}" id="kc-passwd-update-form" method="post">
            <input autocomplete="username" name="username" type="hidden" value="${username}">
            <input autocomplete="current-password" name="password" type="hidden">

            <fieldset class="fieldset mt-4 md:mt-6">
                <legend class="fieldset-legend">${msg("passwordNew")}</legend>
                <label class="input w-full focus:outline-0 <#if messagesPerField.existsError('password','password-confirm')>input-error</#if>">
                    <span class="iconify lucide--key-round text-base-content/80 size-5"></span>
                    <input
                        autocomplete="new-password"
                        autofocus
                        class="grow focus:outline-0"
                        id="password-new"
                        name="password-new"
                        type="password">
                    <button aria-label="${msg("showPassword")}" class="btn btn-xs btn-ghost btn-circle password-toggle" data-target="password-new" type="button">
                        <span class="iconify lucide--eye eye-icon size-4"></span>
                        <span class="iconify lucide--eye-off eye-off-icon size-4" style="display: none"></span>
                    </button>
                </label>
                <#if messagesPerField.existsError('password')>
                    <p aria-live="polite" class="text-error mt-1 text-xs" id="input-error-password">
                        ${kcSanitize(messagesPerField.get('password'))?no_esc}
                    </p>
                </#if>
            </fieldset>

            <fieldset class="fieldset mt-2">
                <legend class="fieldset-legend">${msg("passwordConfirm")}</legend>
                <label class="input w-full focus:outline-0 <#if messagesPerField.existsError('password-confirm')>input-error</#if>">
                    <span class="iconify lucide--key-round text-base-content/80 size-5"></span>
                    <input
                        autocomplete="new-password"
                        class="grow focus:outline-0"
                        id="password-confirm"
                        name="password-confirm"
                        type="password">
                    <button aria-label="${msg("showPassword")}" class="btn btn-xs btn-ghost btn-circle password-toggle" data-target="password-confirm" type="button">
                        <span class="iconify lucide--eye eye-icon size-4"></span>
                        <span class="iconify lucide--eye-off eye-off-icon size-4" style="display: none"></span>
                    </button>
                </label>
                <#if messagesPerField.existsError('password-confirm')>
                    <p aria-live="polite" class="text-error mt-1 text-xs" id="input-error-password-confirm">
                        ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                    </p>
                </#if>
            </fieldset>

            <#if isAppInitiatedAction??>
                <div class="mt-4 flex items-center gap-3 md:mt-6">
                    <input
                        checked
                        class="checkbox checkbox-sm checkbox-primary"
                        id="logout-sessions"
                        name="logout-sessions"
                        type="checkbox"
                        value="on">
                    <label class="text-sm" for="logout-sessions">${msg("logoutOtherSessions")}</label>
                </div>
            </#if>

            <#if isAppInitiatedAction??>
                <div class="mt-4 grid grid-cols-2 gap-3 md:mt-6">
                    <button class="btn btn-ghost border-base-300" name="cancel-aia" type="submit" value="true">
                        ${msg("doCancel")}
                    </button>
                    <button class="btn btn-primary gap-3" id="update-password" type="submit">
                        ${msg("doSubmit")}
                    </button>
                </div>
            <#else>
                <button class="btn btn-primary btn-block mt-4 gap-3 md:mt-6" id="update-password" type="submit">
                    ${msg("doSubmit")}
                </button>
            </#if>
        </form>
    </#if>

</@layout.registrationLayout>
