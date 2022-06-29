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

function abundant(n) {
    if (n==1) {
        return false;
    }
    let ff=1;
    let s=Math.floor(Math.sqrt(n));
    if (s * s == n) {
        ff += s;
        s--;
    }
    for (let pf=2;pf <= s;pf++) {
        if (n % pf == 0) {
            ff += pf;
            ff += Math.floor(n/pf);
            if (ff > n) {
                return true;
            }
        }
    }
    return false;
}

function oddabundant(ct) {
    let n = 1;
    let o = [];
    while (true) {
        if (abundant(n)) {
            o.push(n);
            if (o.length >= ct) {
                break;
            }
        }
        n += 2;
    }
    return o;
}

if (deepEqual(oddabundant(20),[945, 1575, 2205, 2835, 3465, 4095, 4725, 5355, 5775, 5985, 6435, 6615, 6825, 7245, 7425, 7875, 8085, 8415, 8505, 8925])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
