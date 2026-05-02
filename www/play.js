(function () {
    var form = document.getElementById("play-form");
    var nameInput = document.getElementById("player-name");
    var savedName = localStorage.getItem("vapor.playerName");

    if (savedName) {
        nameInput.value = savedName;
    }

    form.addEventListener("submit", function (event) {
        event.preventDefault();

        var playerName = nameInput.value.trim() || "surfer99";
        playerName = playerName.slice(0, 20);

        localStorage.setItem("vapor.playerName", playerName);
        window.location.href = "game.html";
    });
}());
