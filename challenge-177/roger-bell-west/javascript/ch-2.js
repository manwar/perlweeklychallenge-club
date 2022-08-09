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

function isprime(candidate) {
    if (candidate<2) {
        return false
    } else if (candidate==2) {
        return true
    } else if (candidate==3) {
        return true
    } else if (candidate % 2 == 0) {
        return false
    } else if (candidate % 3 == 0) {
        return false
    }
    let anchor=0
    let limit=Math.floor(Math.sqrt(candidate))
    while (1) {
        anchor+=6
        for (let t = anchor-1; t <= anchor+1; t += 2) {
            if (t > limit) {
                return true
            }
            if (candidate % t == 0) {
                return false
            }
        }
    }
}

function ppc(ct) {
    let o = [];
    let fh = 0;
    while (o.length < ct) {
        fh++
        let t = fh;
        let q = false;
        while (t > 0) {
            if (t % 10 == 0) {
                q = true;
                break;
            }
            t = Math.floor(t/10);
        }
        if (q) {
            continue;
        }
        let sfh = fh.toString();
        let c = parseInt(sfh + "0" + sfh.split("").reverse().join(""));
        if (isprime(c)) {
            o.push(c);
        }
        if (o.length >= ct) {
            break;
        }
    }
    return o;
}

if (deepEqual(ppc(20),[101, 16061, 31013, 35053, 38083, 73037, 74047,
                       91019, 94049, 1120211, 1150511, 1160611,
                       1180811, 1190911, 1250521, 1280821, 1360631,
                       1390931, 1490941, 1520251])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
