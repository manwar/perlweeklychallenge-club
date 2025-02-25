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

function aliendictionary(a, dc) {
    const mxl = Math.max(...a.map(x => x.length));
    let dh = new Map;
    dc.forEach((c, i) => {
        dh.set(c, i + 1);
    });
    let b = [...a];
    let numerics = new Map;
    for (let w of a) {
        let n = 0n;
        let cc = w.split("");
        for (let i = 0; i < mxl; i++) {
            n *= 27n;
            if (i < w.length) {
                n += BigInt(dh.get(cc[i]));
            }
        }
        numerics.set(w, n);
    }
    b.sort(function(i, j) {
        const d = numerics.get(i) - numerics.get(j);
        if (d < 0) {
            return -1;
        } else if (d > 0) {
            return 1;
        }
        return 0;
    });
    return b;
}

if (deepEqual(aliendictionary(['perl', 'python', 'raku'], ['h', 'l', 'a', 'b', 'y', 'd', 'e', 'f', 'g', 'i', 'r', 'k', 'm', 'n', 'o', 'p', 'q', 'j', 's', 't', 'u', 'v', 'w', 'x', 'c', 'z']), ['raku', 'python', 'perl'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(aliendictionary(['the', 'weekly', 'challenge'], ['c', 'o', 'r', 'l', 'd', 'a', 'b', 't', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'm', 'n', 'p', 'q', 's', 'w', 'u', 'v', 'x', 'y', 'z']), ['challenge', 'the', 'weekly'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
