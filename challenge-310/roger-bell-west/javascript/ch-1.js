#! /usr/bin/node

"use strict"

function arraysintersection(a) {
    let s = new Set(a[0]);
    for (let bi = 1; bi < a.length; bi++) {
        s = new Set(a[bi].filter(i => s.has(i)));
    }
    let o = [...s];
    o.sort();
    return o;
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

if (deepEqual(arraysintersection([[1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]]), [1, 4])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(arraysintersection([[1, 0, 2, 3], [2, 4, 5]]), [2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(arraysintersection([[1, 2, 3], [4, 5], [6]]), [])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
