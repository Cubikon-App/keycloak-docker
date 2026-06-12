<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>

    <#if section = "header">
        ${msg("loginAccountTitle")}

    <#elseif section = "form">
        <p class="text-base-content/70 mt-2 text-center text-sm">
            ${msg("cubikonLoginSubtitle")}
        </p>

        <#if realm.password>
            <div class="mt-4 md:mt-6">
                <form action="${url.loginAction}" id="kc-form-login" method="post" onsubmit="login.disabled = true; return true;">

                    <#if !usernameHidden??>
                        <fieldset class="fieldset">
                            <legend class="fieldset-legend">
                                <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
                            </legend>
                            <label class="input w-full focus:outline-0 <#if messagesPerField.existsError('username','password')>input-error</#if>">
                                <span class="iconify lucide--mail text-base-content/80 size-5"></span>
                                <input
                                    autocomplete="<#if realm.loginWithEmailAllowed>email<#else>username</#if>"
                                    autofocus
                                    class="grow focus:outline-0"
                                    id="username"
                                    name="username"
                                    placeholder="<#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>"
                                    type="<#if realm.loginWithEmailAllowed && realm.registrationEmailAsUsername>email<#else>text</#if>"
                                    value="${(login.username!'')}">
                            </label>
                            <#if messagesPerField.existsError('username','password')>
                                <p aria-live="polite" class="text-error mt-1 text-xs" id="input-error">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                </p>
                            </#if>
                        </fieldset>
                    </#if>

                    <fieldset class="fieldset">
                        <legend class="fieldset-legend">${msg("password")}</legend>
                        <label class="input w-full focus:outline-0 <#if messagesPerField.existsError('username','password')>input-error</#if>">
                            <span class="iconify lucide--key-round text-base-content/80 size-5"></span>
                            <input
                                autocomplete="current-password"
                                class="grow focus:outline-0"
                                id="password"
                                name="password"
                                placeholder="${msg("password")}"
                                type="password">
                            <button aria-label="${msg("showPassword")}" class="btn btn-xs btn-ghost btn-circle" id="password-toggle" type="button">
                                <span class="iconify lucide--eye size-4" id="eye-icon"></span>
                                <span class="iconify lucide--eye-off size-4" id="eye-off-icon" style="display: none"></span>
                            </button>
                        </label>
                        <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                            <p aria-live="polite" class="text-error mt-1 text-xs" id="input-error">
                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </p>
                        </#if>
                    </fieldset>

                    <#if realm.resetPasswordAllowed>
                        <div class="mt-1 text-end">
                            <a class="text-base-content/80 text-xs hover:underline" href="${url.loginResetCredentialsUrl}">
                                ${msg("doForgotPassword")}
                            </a>
                        </div>
                    </#if>

                    <#if realm.rememberMe && !usernameHidden??>
                        <div class="mt-4 flex items-center gap-3 md:mt-6">
                            <input
                                class="checkbox checkbox-sm checkbox-primary"
                                id="rememberMe"
                                name="rememberMe"
                                type="checkbox"
                                <#if login.rememberMe??>checked</#if>>
                            <label class="text-sm" for="rememberMe">${msg("rememberMe")}</label>
                        </div>
                    </#if>

                    <input id="id-hidden-input" name="credentialId" type="hidden"
                        <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>>

                    <button class="btn btn-primary btn-block mt-4 gap-3 md:mt-6" id="kc-login" name="login" type="submit">
                        <span class="iconify lucide--log-in size-4"></span>
                        ${msg("doLogIn")}
                    </button>
                </form>
            </div>
        </#if>

    <#elseif section = "socialProviders">
        <#if realm.password && social?? && social.providers?has_content>
            <div class="divider text-base-content/60 mt-6 text-xs">${msg("identity-provider-login-label")}</div>
            <#list social.providers as p>
                <a class="btn btn-ghost btn-block border-base-300 mt-2 gap-3" href="${p.loginUrl}" id="social-${p.alias}">
                    <img alt="" class="size-6" onerror="this.remove()" src="${url.resourcesPath}/img/${p.alias}-mini.svg">
                    ${p.displayName!}
                </a>
            </#list>
        </#if>

    <#elseif section = "info">
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <span>${msg("noAccount")}</span>
            <a class="text-primary ms-1 hover:underline" href="${url.registrationUrl}">${msg("doRegister")}</a>
        </#if>
    </#if>

</@layout.registrationLayout>
