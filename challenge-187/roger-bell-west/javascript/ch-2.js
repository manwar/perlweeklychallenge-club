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

function magicaltriplets(a) {
    let out = [];
    let mv = 0;
    for (let ai = 0; ai < a.length-2; ai++) {
        for (let bi = ai+1; bi < a.length-1; bi++) {
            for (let ci = bi+1; ci < a.length; ci++) {
                if (a[ai] + a[bi] > a[ci] &&
                    a[bi] + a[ci] > a[ai] &&
                    a[ai] + a[ci] > a[bi]) {
                    let v = a[ai] + a[bi] + a[ci];
                    if (v > mv) {
                        mv = v;
                        out = [a[ai], a[bi], a[ci]];
                    }
                }
            }
        }
    }
    out.sort(function(a,b) {
        return b-a;
    });
    return out;
}

if (deepEqual(magicaltriplets([1, 2, 3, 2]),
              [3, 2, 2])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(magicaltriplets([1, 3, 2]),
              [])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(magicaltriplets([1, 1, 2, 3]),
              [])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(magicaltriplets([2, 4, 3]),
              [4, 3, 2])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}

process.stdout.write("\n");
