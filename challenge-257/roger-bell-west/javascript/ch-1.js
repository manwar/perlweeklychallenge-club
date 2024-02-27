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

function smallerthancurrent(a) {
    let s = [...a];
    s.sort(function(a,b) {
        return a-b;
    });
    let l = new Map;
    s.forEach((n, i) => {
        if (!l.has(n)) {
            l.set(n, i);
        }
    });
    return a.map(n => l.get(n));
}

if (deepEqual(smallerthancurrent([5, 2, 1, 6]), [2, 1, 0, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(smallerthancurrent([1, 2, 0, 3]), [1, 2, 0, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(smallerthancurrent([0, 1]), [0, 1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(smallerthancurrent([9, 4, 9, 2]), [2, 1, 2, 0])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
