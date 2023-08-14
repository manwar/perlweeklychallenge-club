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

function separatedigits(a) {
    let out = [];
    for (let n of a) {
        let m = n;
        let v = [];
        while (m > 0) {
            v.push(m % 10);
            m = Math.trunc(m / 10);
        }
        v.reverse();
        out.push(...v);
    }
    return out;
}

if (deepEqual(separatedigits([1, 34, 5, 6]), [1, 3, 4, 5, 6])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(separatedigits([1, 24, 51, 60]), [1, 2, 4, 5, 1, 6, 0])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
