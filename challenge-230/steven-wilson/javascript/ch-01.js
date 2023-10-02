"use strict";

function separateDigits(...elements) {
    return elements.map((elem) => elem.toString()
            .split(""))
        .flat()
        .map(Number);
}
