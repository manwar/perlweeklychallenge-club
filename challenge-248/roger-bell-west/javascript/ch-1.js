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

function shortestdistance(a, c) {
    let q = [];
    let i = 0;
    while (i >= 0) {
        const p = a.indexOf(c, i);
        if (p >= 0) {
            q.push([p, 0]);
            i = p + 1;
        } else {
            i = -1;
        }
    }
    const invalid = a.length + 1;
    let out = Array(a.length).fill().map((element, index) => invalid);
    while (q.length > 0) {
        let [i, v] = q.shift();
        if (out[i] == invalid) {
            out[i] = v;
            if (i > 0) {
                q.push([i - 1, v + 1]);
            }
            if (i < a.length - 1) {
                q.push([i + 1, v + 1]);
            }
        }
    }
    return out;
}

if (deepEqual(shortestdistance('loveleetcode', 'e'), [3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(shortestdistance('aaab', 'b'), [3, 2, 1, 0])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
