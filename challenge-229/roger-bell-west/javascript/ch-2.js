#! /usr/bin/node

"use strict"

function twoofthree(a) {
    let ct = new Map();
    for (let iv of a) {
        for (let c of new Set(iv)) {
            if (ct.has(c)) {
                ct.set(c, ct.get(c) + 1);
            } else {
                ct.set(c, 1);
            }
        }
    }
    let out = [];
    for (const [k, v] of ct) {
        if (v >= 2) {
            out.push(k);
        }
    }
    out.sort();
    return out;
}

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

if (deepEqual(twoofthree([[1, 1, 2, 4], [2, 4], [4]]), [2, 4])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(twoofthree([[4, 1], [2, 4], [1, 2]]), [1, 2, 4])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
