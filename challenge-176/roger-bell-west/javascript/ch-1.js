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

function permutable() {
    let n = 0;
    while (true) {
        n++;
        let base = n.toString().split("");
        base.sort();
        let q = true;
        for (let k = 2; k <= 6; k++) {
            let tt = (n*k).toString().split("");
            tt.sort();
            if (!deepEqual(tt,base)) {
                q = false;
                break;
            }
        }
        if (q) {
            return n;
        }
    }
}

if (permutable() == 142857) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
