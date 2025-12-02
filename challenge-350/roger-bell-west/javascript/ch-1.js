#! /usr/bin/node

"use strict"

// by VLAZ
// https://stackoverflow.com/a/59322890
function toWindows(inputArray, size) {
  return Array.from(
    {length: inputArray.length - (size - 1)}, //get the appropriate length
    (_, index) => inputArray.slice(index, index+size) //create the windows
  )
}

function counterify(a) {
    let cc = new Map;
    for (let x of a) {
        if (!cc.has(x)) {
            cc.set(x, 0);
        }
        cc.set(x, cc.get(x) + 1);
    }
    return cc;
}

function goodsubstrings(a) {
    let p = 0;
    for (let s of toWindows(a.split(""), 3)) {
        const c = counterify(s);
        if (Math.max(...c.values()) == 1) {
            p++;
        }
    }
    return p;
}
    

if (goodsubstrings('abcaefg') == 5) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (goodsubstrings('xyzzabc') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (goodsubstrings('aababc') == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (goodsubstrings('qwerty') == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (goodsubstrings('zzzaaa') == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
