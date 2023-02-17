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

function reshapematrix(m, r, c) {
    let mv = m.flat();
    if (r * c != mv.length) {
        return [[0]];
    }
    let out = [];
    for (let i = 0; i < r; i++) {
        out.push(mv.slice(i * c, (i + 1) * c));
    }
    return out;
}

if (deepEqual(reshapematrix([[1, 2], [3, 4]], 1, 4), [[1, 2, 3, 4]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(reshapematrix([[1, 2, 3], [4, 5, 6]], 3, 2), [[1, 2], [3, 4], [5, 6]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(reshapematrix([[1, 2]], 3, 2), [[0]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
