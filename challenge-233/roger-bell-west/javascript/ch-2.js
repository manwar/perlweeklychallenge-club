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

function frequencysort(a) {
    let ct = new Map();
    for (let x of a) {
        if (ct.has(x)) {
            ct.set(x, ct.get(x) + 1);
        } else {
            ct.set(x, 1);
        }
    }
    let rct = new Map();
    for (const [k, v] of ct) {
        let pp = [];
        if (rct.has(v)) {
            pp = rct.get(v);
        }
        pp.push(k);
        rct.set(v, pp);
    }
    let out = [];
    let kk = Array.from(rct.keys());
    kk.sort(function(a,b) {
        return a-b;
    });
    for (let k of kk) {
        let pp = rct.get(k);
        pp.sort(function(a,b) {
            return b-a;
        });
        for (let v of pp) {
            for (let i = 0; i < k; i++) {
                out.push(v);
            }
        }
    }
    return out;
}

if (deepEqual(frequencysort([1, 1, 2, 2, 2, 3]), [3, 1, 1, 2, 2, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(frequencysort([2, 3, 1, 3, 2]), [1, 3, 3, 2, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(frequencysort([-1, 1, -6, 4, 5, -6, 1, 4, 1]), [5, -1, 4, 4, -6, -6, 1, 1, 1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
