"use strict";


function pluckMinMax(elements) {
    if (elements.length < 3) {
        return -1;
    }
    let removePositions = [];
    removePositions.push(elements.indexOf(Math.min(...elements)));
    removePositions.push(elements.indexOf(Math.max(...elements)));
    for (let position of removePositions.sort((a, b) => b - a)) {
        elements.splice(position, 1);
    }
    return elements;
}
