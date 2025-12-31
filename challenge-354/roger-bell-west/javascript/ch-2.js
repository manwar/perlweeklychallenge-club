#! /usr/bin/node

"use strict"

function shiftgrid(gi, k0) {
    const wi = gi.flat();
    const k = k0 % wi.length;
    const wo = wi.slice(wi.length - k).concat(wi.slice(0, wi.length - k));
    return windows(wo, gi[0].length, gi[0].length);
}

function windows(a, size, offset) {
    let out = [];
    for (let i = 0; i <= a.length - size; i += offset) {
        let w = [];
        for (let j = 0; j < size; j++) {
            if (i + j < a.length) {
                w.push(a[i + j]);
            }
        }
        out.push(w);
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

if (deepEqual(shiftgrid([[1, 2, 3], [4, 5, 6], [7, 8, 9]], 1), [[9, 1, 2], [3, 4, 5], [6, 7, 8]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(shiftgrid([[10, 20], [30, 40]], 1), [[40, 10], [20, 30]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(shiftgrid([[1, 2], [3, 4], [5, 6]], 1), [[6, 1], [2, 3], [4, 5]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(shiftgrid([[1, 2, 3], [4, 5, 6]], 5), [[2, 3, 4], [5, 6, 1]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(shiftgrid([[1, 2, 3, 4]], 1), [[4, 1, 2, 3]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
