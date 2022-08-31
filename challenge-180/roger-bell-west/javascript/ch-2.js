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

function trimlist(n, i) {
    return n.filter(e => e > i);
}

if (deepEqual(trimlist([1, 4, 2, 3, 5], 3), [4, 5])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(trimlist([9, 0, 6, 2, 3, 8, 5], 4), [9, 6, 8, 5])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
