#! /usr/bin/node

"use strict"

const fs = require("fs")
let buffer = fs.readFileSync("temperature.txt", "utf8");
let t = new Map();
buffer.split(/[\r\n]+/).forEach(line => {
    if (line.length > 0) {
        let l = line.split(/, */);
        t.set(l[0],parseInt(l[1]));
    }
});
let lt = 999;
let kt = [...t.keys()];
kt.sort();
for (let k of kt) {
    if (t.get(k) > lt) {
        console.log(k);
    }
    lt = t.get(k);
}
