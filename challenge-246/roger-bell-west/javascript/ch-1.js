#! /usr/bin/node

"use strict"

function shuffleArray(input) {
    let keys = Array(input.length).fill().map((element, index) => Math.random());
    let ix = Array(input.length).fill().map((element, index) => index);
    ix.sort(function(a, b) {
        return keys[a] - keys[b];
    });
    return ix.map(n => input[n]);
}

function sixoffortynine() {
    let candidates = Array(49).fill().map((element, index) => index + 1);
    candidates = shuffleArray(candidates);
    candidates.length = 6;
    candidates.sort(function(a, b) {
        return a - b;
    });
    console.log(JSON.stringify(candidates));
}

sixoffortynine();
