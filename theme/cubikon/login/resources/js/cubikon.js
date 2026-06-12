(function () {
    "use strict";

    function init() {
        var themeToggle = document.getElementById("cubikon-theme-toggle");
        if (themeToggle) {
            themeToggle.addEventListener("click", function () {
                var next = document.documentElement.getAttribute("data-theme") === "dark" ? "light" : "dark";
                document.documentElement.setAttribute("data-theme", next);
                try { localStorage.setItem("cubikon-theme", next); } catch (e) {}
            });
        }

        var passwordToggle = document.getElementById("password-toggle");
        var password = document.getElementById("password");
        if (passwordToggle && password) {
            passwordToggle.addEventListener("click", function () {
                var show = password.type === "password";
                password.type = show ? "text" : "password";
                document.getElementById("eye-icon").classList.toggle("hidden", show);
                document.getElementById("eye-off-icon").classList.toggle("hidden", !show);
            });
        }
    }

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", init);
    } else {
        init();
    }
})();
