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

function uniquearray(n) {
    let o = [];
    let oh = new Set();
    for (let i of n) {
        let ti = JSON.stringify(i);
        if (!oh.has(ti)) {
            o.push(i);
            oh.add(ti);
        }
    }
    return o;
}

if (deepEqual(uniquearray([[1,2], [3,4], [5,6], [1,2]]),
              [[1,2], [3,4], [5,6]])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(uniquearray([[9,1], [3,7], [2,5], [2,5]]),
              [[9,1], [3,7], [2,5]])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
