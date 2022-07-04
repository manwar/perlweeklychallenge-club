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

function fivenumber(n0) {
    let n = [...n0];
    n.sort();
    let nl = n.length - 1;
    let o = [ n[0] ];
    for (let quartile = 1; quartile <= 3; quartile++) {
        let bx = quartile * nl;
        let base = Math.floor(bx / 4);
        let v = n[base];
        if (bx % 4 != 0) {
            v = (n[base] + n[base+1]) / 2;
        }
        o.push(v);
    }
    o.push(n[n.length - 1]);
    return o;
}

if (deepEqual(fivenumber([0, 0, 1, 2, 63, 61, 27, 13]),
              [0, 0.5, 7.5, 44, 63])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
