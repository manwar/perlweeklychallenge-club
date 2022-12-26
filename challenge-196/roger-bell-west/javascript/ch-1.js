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

function pattern132(l) {
    let o = [];
    for (let a = 0; a < l.length-2; a++) {
        for (let b = a+1; b < l.length-1; b++) {
            if (l[a] < l[b]) {
                for (let c = b+1; c < l.length; c++) {
                    if (l[b] > l[c] && l[a] < l[c]) {
                        o = [l[a], l[b], l[c]]
                        break
                    }
                }
            }
            if (o.length > 0) {
                break
            }
        }
        if (o.length > 0) {
            break
        }
    }
    return o;
}

if (deepEqual(pattern132([3, 1, 4, 2]), [1, 4, 2])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(pattern132([1, 2, 3, 4]), [])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(pattern132([1, 3, 2, 4, 6, 5]), [1, 3, 2])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(pattern132([1, 3, 4, 2]), [1, 3, 2])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
