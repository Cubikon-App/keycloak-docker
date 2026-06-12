<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html lang="${(locale.currentLanguageTag)!'en'}" data-theme="light">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title>${msg("loginTitle", (realm.displayName!''))}</title>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet">
        </#list>
    </#if>
    <script>
        (function () {
            var theme;
            try { theme = localStorage.getItem("cubikon-theme"); } catch (e) {}
            if (!theme) {
                theme = window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
            }
            document.documentElement.setAttribute("data-theme", theme);
        })();
    </script>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" defer></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
</head>
<body class="${bodyClass}">
    <div class="flex min-h-screen items-center justify-center p-4">
        <main class="card bg-base-100 w-full max-w-md shadow-xl">
            <div class="flex flex-col items-stretch p-6 md:p-10">

                <div class="flex items-center justify-between">
                    <a class="flex items-center gap-2" href="${properties.logoLink!'#'}">
                        <#if properties.logoUrl?has_content>
                            <img alt="${realm.displayName!''}" class="h-8" src="${properties.logoUrl}">
                        <#else>
                            <span class="text-xl font-bold">${kcSanitize(realm.displayNameHtml!(realm.displayName!'Cubikon'))?no_esc}</span>
                        </#if>
                    </a>
                    <div class="flex items-center gap-2">
                        <#if realm.internationalizationEnabled?? && realm.internationalizationEnabled && locale.supported?size gt 1>
                            <div class="dropdown dropdown-end">
                                <div class="btn btn-ghost btn-sm gap-1" role="button" tabindex="0">
                                    ${locale.current}
                                    <span class="iconify lucide--chevron-down size-4"></span>
                                </div>
                                <ul class="dropdown-content menu bg-base-100 rounded-box z-10 mt-1 w-40 p-2 shadow" tabindex="0">
                                    <#list locale.supported as l>
                                        <li><a href="${l.url}">${l.label}</a></li>
                                    </#list>
                                </ul>
                            </div>
                        </#if>
                        <button aria-label="Toggle theme" class="btn btn-circle btn-outline border-base-300" id="cubikon-theme-toggle" type="button">
                            <span class="iconify lucide--moon cubikon-when-light size-5"></span>
                            <span class="iconify lucide--sun cubikon-when-dark size-5"></span>
                        </button>
                    </div>
                </div>

                <h3 class="mt-8 text-center text-xl font-semibold md:mt-10">
                    <#nested "header">
                </h3>

                <#if displayRequiredFields>
                    <p class="text-base-content/70 mt-2 text-center text-xs">
                        <span class="text-error">*</span> ${msg("requiredFields")}
                    </p>
                </#if>

                <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                    <div class="alert mt-4 text-sm <#if message.type = 'error'>alert-error<#elseif message.type = 'warning'>alert-warning<#elseif message.type = 'success'>alert-success<#else>alert-info</#if>">
                        <span class="iconify lucide--circle-alert size-4"></span>
                        <span>${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                </#if>

                <#nested "form">

                <#if auth?has_content && auth.showTryAnotherWayLink()>
                    <form action="${url.loginAction}" class="mt-4 text-center" id="kc-select-try-another-way-form" method="post">
                        <input name="tryAnotherWay" type="hidden" value="on">
                        <a class="link text-sm" href="#" id="try-another-way"
                           onclick="document.forms['kc-select-try-another-way-form'].requestSubmit(); return false;">
                            ${msg("doTryAnotherWay")}
                        </a>
                    </form>
                </#if>

                <#nested "socialProviders">

                <#if displayInfo>
                    <div class="text-base-content/80 mt-4 text-center text-sm md:mt-6">
                        <#nested "info">
                    </div>
                </#if>
            </div>
        </main>
    </div>
</body>
</html>
</#macro>
