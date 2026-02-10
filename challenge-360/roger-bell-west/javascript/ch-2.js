#! /usr/bin/node

"use strict"

function range(from, to) {
    let a = new Array();
    for (let i = from; i <= to; i++) {
        a.push(i);
    }
    return a;
}

function wordsorter(a) {
    let w = a.split(" ").filter(i => i != "");
    let wl = w.map(x => x.toLowerCase());
    let i = range(0, w.length - 1);
    i.sort(function(a, b) {
        return ('' + wl[a]).localeCompare(wl[b]);
    });
    w = i.map(x => w[x]);
    return w.join(" ");
}

if (wordsorter('The quick brown fox') == 'brown fox quick The') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (wordsorter('Hello    World!   How   are you?') == 'are Hello How World! you?') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (wordsorter('Hello') == 'Hello') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (wordsorter('Hello, World! How are you?') == 'are Hello, How World! you?') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (wordsorter('I have 2 apples and 3 bananas!') == '2 3 and apples bananas! have I') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
