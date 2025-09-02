#! /usr/bin/node

"use strict"

function smallerthancurrent(a) {
    let b = [...a];
    b.sort(function(a, b) {return a-b});
    let m = new Map;
    b.forEach((v, i) => {
        if (!m.has(v)) {
            m.set(v, i);
        }
    });
    return a.map( x => m.get(x) );
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

if (deepEqual(smallerthancurrent([6, 5, 4, 8]), [2, 1, 0, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(smallerthancurrent([7, 7, 7, 7]), [0, 0, 0, 0])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(smallerthancurrent([5, 4, 3, 2, 1]), [4, 3, 2, 1, 0])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(smallerthancurrent([-1, 0, 3, -2, 1]), [1, 2, 4, 0, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(smallerthancurrent([0, 1, 1, 2, 0]), [0, 2, 2, 4, 0])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
