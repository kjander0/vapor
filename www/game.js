(function () {
    var canvas = document.getElementById("game-canvas");
    var gl = canvas.getContext("webgl", {
        alpha: false,
        antialias: false,
        depth: true,
        stencil: false,
        preserveDrawingBuffer: false
    });

    if (!gl) {
        console.error("WebGL is not available in this browser.");
        return;
    }

    function resize() {
        var ratio = window.devicePixelRatio || 1;
        var width = Math.floor(window.innerWidth * ratio);
        var height = Math.floor(window.innerHeight * ratio);

        if (canvas.width !== width || canvas.height !== height) {
            canvas.width = width;
            canvas.height = height;
        }

        canvas.style.width = window.innerWidth + "px";
        canvas.style.height = window.innerHeight + "px";
        gl.viewport(0, 0, canvas.width, canvas.height);
    }

    window.vaporGame = {
        canvas: canvas,
        gl: gl,
        playerName: localStorage.getItem("vapor.playerName") || "surfer99"
    };

    window.addEventListener("resize", resize);
    resize();
}());
