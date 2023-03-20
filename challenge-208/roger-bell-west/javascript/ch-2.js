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

function duplicateandmissing(a) {
    let flags = 0;
    let dup = 0;
    let mis = 0;
    let exp = a[0] + 1;
    for (let n of a.slice(1)) {
        if (n < exp) {
            dup = n
            flags |= 1;
        } else if (n > exp) {
            mis = exp;
            flags |= 2;
        }
        if (flags == 3) {
            return [dup, mis];
        }
        exp = n + 1;
    }
    if (flags == 1) {
        return [dup, exp];
    }
    return [-1];
}

if (deepEqual(duplicateandmissing([1, 2, 2, 4]), [2, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(duplicateandmissing([1, 2, 3, 4]), [-1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(duplicateandmissing([1, 2, 3, 3]), [3, 4])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
