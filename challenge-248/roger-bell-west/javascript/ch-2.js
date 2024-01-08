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

function submatrixsum(a) {
    let out = [];
    for (let y = 0; y < a.length - 1; y++) {
        let row = [];
        for (let x = 0; x < a[y].length - 1; x++) {
            let s = 0;
            for (let ya = y; ya <= y + 1; ya++) {
                for (let xa = x; xa <= x + 1; xa++) {
                    s += a[ya][xa];
                }
            }
            row.push(s);
        }
        out.push(row);
    }
    return out;
}

if (deepEqual(submatrixsum([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]), [[14, 18, 22], [30, 34, 38]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(submatrixsum([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]), [[2, 1, 0], [1, 2, 1], [0, 1, 2]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
