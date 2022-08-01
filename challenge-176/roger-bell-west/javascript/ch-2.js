#! /usr/bin/node

"use strict"

function deepEqual(a,b)
{
    if( (typeof a == 'object' && a != null) &&
        (typeof b == 'object' && b != null) )
    {
        var count = [0,0]
        for( var key in a) count[0]++
        for( var key in b) count[1]++
        if( count[0]-count[1] != 0) {return false}
        for( var key in a)
        {
            if(!(key in b) || !deepEqual(a[key],b[key])) {return false}
        }
        for( var key in b)
        {
            if(!(key in a) || !deepEqual(b[key],a[key])) {return false}
        }
        return true
    }
    else
    {
        return a === b
    }
}

function reversible(mx) {
    let o = [];
    for (let n = 1; n <= mx; n++) {
        let t = n + parseInt(n.toString().split("").reverse().join(""));
        let q = true;
        while (t > 0) {
            if (t % 2 == 0) {
                q = false;
                break;
            }
            t = Math.floor(t/10);
        }
        if (q) {
            o.push(n);
        }
    }
    return o;
}

if (deepEqual(reversible(99),[10, 12, 14, 16, 18, 21, 23, 25, 27, 30,
                              32, 34, 36, 41, 43, 45, 50, 52, 54, 61,
                              63, 70, 72, 81, 90])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
