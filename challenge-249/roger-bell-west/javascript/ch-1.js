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

function shortestdistance(a0) {
    if (a0.length % 2 != 0) {
        return [];
    }
    let a = a0;
    a.sort();
    let out = [];
    for (let i = 0; i < a.length; i += 2) {
        if (a[i] != a[i + 1]) {
            return [];
        }
        out.push([a[i], a[i]]);
    }
    return out;
}

if (deepEqual(shortestdistance([3, 2, 3, 2, 2, 2]), [[2, 2], [2, 2], [3, 3]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(shortestdistance([1, 2, 3, 4]), [])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
