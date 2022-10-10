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

function splitarray(list) {
    let out = [[], []];
    for (let ins of list) {
        let av = [];
        let bv = [];
        for (let c of ins) {
            if (c >= '0' && c <= '9') {
                av.push(parseInt(c));
            } else if (c >= 'a' && c <= 'z') {
                bv.push(c);
            }
        }
        if (av.length > 0) {
            out[0].push(av);
        }
        if (bv.length > 0) {
            out[1].push(bv);
        }
    }
    return out;
}

if (deepEqual(splitarray(["a 1 2 b 0", "3 c 4 d"]),
              [ [[1, 2, 0], [3, 4]], [['a', 'b'], ['c', 'd']] ])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(splitarray(["1 2", "p q r", "s 3", "4 5 t"]),
              [ [[1, 2], [3], [4, 5]],
                [['p', 'q', 'r'], ['s'], ['t']] ])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
