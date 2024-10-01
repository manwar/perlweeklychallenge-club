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

function jumble(a) {
    return shuffleArray(a.split("")).join("");
}

const wordrx = /([A-Za-z])([A-Za-z][A-Za-z]+)([A-Za-z])/g;
const readable = process.stdin;
let buffer = "";
readable.on('readable', () => {
    let chunk;
    while (null !== (chunk = readable.read())) {
        buffer += chunk;
    }
})
readable.on('end', () => {
    buffer.split(/[\r\n]+/).forEach(line => {
        process.stdout.write(line.replace(wordrx, (t, x, y, z) => x + jumble(y) + z) + "\n");
    });
});
