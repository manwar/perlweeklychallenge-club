#!/usr/bin/env node

// run <script> <number>

function fstRunOver(s1,s2) {
    return [...Array(s2.length).keys()].map(i => [...Array(i+1).keys()].map(x => x+parseInt(s1))).find(xs => s2.length <= xs.map(x => x.toString().length).reduce((x,y) => x+y))
}

function consecSplit(s) {
    return [...Array(s.length).keys()].map(i => s.substr(0,i+1)).map(x => fstRunOver(x,s)).find(xs => xs.join("") === s)
}

console.log(consecSplit(process.argv[2]))
