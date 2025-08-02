#! /usr/bin/node

"use strict"

function popcount64(x0) {
    const M1  = 0x5555555555555555n;
    const M2  = 0x3333333333333333n;
    const M4  = 0x0f0f0f0f0f0f0f0fn;
    const H01 = 0x0101010101010101n;
    let x = BigInt(x0);
    x -= (x >> 1n) & M1;
    x = (x & M2) + ((x >> 2n) & M2);
    x = (x + (x >> 4n)) & M4;
    return Number((x * H01) >> 56n);
}

function sortbyonebits(a) {
    let b = a;
    let c = new Map;
    for (let n of a) {
        c.set(n, popcount64(n));
    }
    b.sort(function(aa, bb) {
        if (c.get(aa) == c.get(bb)) {
            return aa - bb;
        } else {
            return c.get(aa) - c.get(bb);
        }
    });
    return b;
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

if (deepEqual(sortbyonebits([0, 1, 2, 3, 4, 5, 6, 7, 8]), [0, 1, 2, 4, 8, 3, 5, 6, 7])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(sortbyonebits([1024, 512, 256, 128, 64]), [64, 128, 256, 512, 1024])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
