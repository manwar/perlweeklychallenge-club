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

function rankarray(a) {
    const b = Array.from(new Set(a));
    b.sort(function(p, q) {
        return p - q;
    });
    let c = new Map();
    b.forEach((n, i) => {
        c.set(n, i + 1);
    });
    let out = [];
    for (let v of a) {
        out.push(c.get(v));
    }
    return out;
}

if (deepEqual(rankarray([55, 22, 44, 33]), [4, 1, 3, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(rankarray([10, 10, 10]), [1, 1, 1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(rankarray([5, 1, 1, 4, 3]), [4, 1, 1, 3, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
