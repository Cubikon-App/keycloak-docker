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

        var passwordToggles = document.querySelectorAll(".password-toggle");
        passwordToggles.forEach(function (toggle) {
            var input = document.getElementById(toggle.getAttribute("data-target"));
            var eyeIcon = toggle.querySelector(".eye-icon");
            var eyeOffIcon = toggle.querySelector(".eye-off-icon");
            if (!input) return;
            toggle.addEventListener("click", function () {
                var show = input.type === "password";
                input.type = show ? "text" : "password";
                eyeIcon.style.display = show ? "none" : "";
                eyeOffIcon.style.display = show ? "" : "none";
            });
        });
    }

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", init);
    } else {
        init();
    }
})();
