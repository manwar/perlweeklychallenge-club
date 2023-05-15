#! /usr/bin/node

"use strict"

// by Frank Tan
// https://stackoverflow.com/questions/38400594/javascript-deep-comparison
function deepEqual(a,b)
{
    if( (typeof a == 'object' && a != null) &&
        (typeof b == 'object' && b != null) )
    {
        var count = [0,0];
        for( var key in a) count[0]++;
        for( var key in b) count[1]++;
        if( count[0]-count[1] != 0) {return false;}
        for( var key in a)
        {
            if(!(key in b) || !deepEqual(a[key],b[key])) {return false;}
        }
        for( var key in b)
        {
            if(!(key in a) || !deepEqual(b[key],a[key])) {return false;}
        }
        return true;
    }
    else
    {
        return a === b;
    }
}

function word2set(word) {
    let r = new Set();
    for (let c of word.toLowerCase()) {
        if (c >= 'a' && c <= 'z') {
            r.add(c);
        }
    }
    return r
}

function registrationnumber(words, reg) {
    let out = [];
    for (let w of words) {
        let ss = word2set(reg);
        for (let char of word2set(w)) {
            if (ss.has(char)) {
                ss.delete(char);
                if (ss.size == 0) {
                    out.push(w);
                    break;
                }
            }
        }
    }
    return out;
}

if (deepEqual(registrationnumber(['abc', 'abcd', 'bcd'], 'AB1 2CD'), ['abcd'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(registrationnumber(['job', 'james', 'bjorg'], '007 JB'), ['job', 'bjorg'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(registrationnumber(['crack', 'road', 'rac'], 'C7 RA2'), ['crack', 'rac'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
