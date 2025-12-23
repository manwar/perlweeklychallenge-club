#! /usr/bin/node

"use strict"

function binaryprefix(a) {
    let c = 0;
    let out = []
    for (let n of a) {
        c *= 2;
        c += n;
        out.push(c % 5 == 0);
    }
    return out;
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

if (deepEqual(binaryprefix([0, 1, 1, 0, 0, 1, 0, 1, 1, 1]), [true, false, false, false, false, true, true, false, false, false])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(binaryprefix([1, 0, 1, 0, 1, 0]), [false, false, true, true, false, false])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(binaryprefix([0, 0, 1, 0, 1]), [true, true, false, false, true])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(binaryprefix([1, 1, 1, 1, 1]), [false, false, false, true, false])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(binaryprefix([1, 0, 1, 1, 0, 1, 0, 0, 1, 1]), [false, false, true, false, false, true, true, true, false, false])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
