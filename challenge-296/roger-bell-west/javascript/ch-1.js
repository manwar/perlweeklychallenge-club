#! /usr/bin/node

"use strict"

function compressedunit(count, letter) {
    let out = "";
    if (count > 1) {
        out += count;
    }
    out += letter;
    return out;
}

function stringcompression(a) {
    let out = "";
    let lastchar = '@';
    let count = 0;
    for (let c of a) {
        if (count == 0 || c != lastchar) {
            if (count > 0) {
                out += compressedunit(count, lastchar);
            }
            lastchar = c;
            count = 0;
        }
        count += 1;
    }
    if (count > 0) {
        out += compressedunit(count, lastchar);
    }
    return out;
}

function stringdecompression(a) {
    let out = "";
    let count = 0;
    for (let c of a) {
        if (c >= '0' && c <= '9') {
            count *= 10;
            count += parseInt(c);
        } else {
            if (count == 0) {
                count = 1;
            }
            out += c.repeat(count);
            count = 0;
        }
    }
    return out
}

if (stringcompression('abbc') == 'a2bc') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (stringcompression('aaabccc') == '3ab3c') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (stringcompression('abcc') == 'ab2c') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (stringdecompression('a2bc') == 'abbc') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (stringdecompression('3ab3c') == 'aaabccc') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (stringdecompression('ab2c') == 'abcc') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
