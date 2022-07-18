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

function disarium(ct) {
    let o = [];
    let pows = [new Array(10).fill(1)];
    let c = 0;
    while (true) {
        let disar = 0;
        if (c > 0) {
            let ca = c;
            let cl = [];
            let tx = 0;
            while (ca > 0) {
                tx++;
                cl.push(ca % 10);
                ca = Math.floor(ca / 10);
            }
            cl.reverse();
            if (tx >= pows.length) {
                for (let power = pows.length; power <= tx; power++) {
                    let row = [];
                    for (let digit = 0; digit <= 9; digit++) {
                        row.push(pows[power-1][digit] * digit);
                    }
                    pows.push(row);
                }
            }
            for (let i = 0; i < cl.length; i++) {
                disar += pows[i+1][cl[i]];
            }
        }
        if (disar == c) {
            o.push(c);
            if (o.length >= ct) {
                break;
            }
        }
        c++;
    }
    return o;
}

if (deepEqual(disarium(19),[ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 89, 135,
                             175, 518, 598, 1306, 1676, 2427, 2646798
                           ])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
