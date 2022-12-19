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

function rangelist(l) {
    let o = [];
    let start = l[0];
    let prev = start;
    for (let v of l.slice(1)) {
        if (v != prev + 1) {
            if (prev > start) {
                o.push([start, prev]);
            }
            start = v;
        }
        prev = v;
    }
    if (prev > start) {
        o.push([start, prev]);
    }
    return o;
}

if (deepEqual(rangelist([1, 3, 4, 5, 7]), [[3, 5]])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(rangelist([1, 2, 3, 6, 7, 9]), [[1, 3], [6, 7]])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(rangelist([0, 1, 2, 4, 5, 6, 8, 9]), [[0, 2], [4, 6], [8, 9]])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
