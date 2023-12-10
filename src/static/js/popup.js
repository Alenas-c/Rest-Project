// JavaScript pour ouvrir et fermer le pop-up
document.addEventListener('DOMContentLoaded', function() {
    var authBtn = document.getElementById('authBtn');
    var authPopup = document.getElementById('authPopup');
    var closePopup = document.getElementById('closePopup');

    if (authBtn && authPopup && closePopup) {
        authBtn.onclick = function() {
            authPopup.style.display = 'block';
        };
        closePopup.onclick = function() {
            authPopup.style.display = 'none';
        };
    }
});
