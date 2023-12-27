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

function distringmatch(a) {
    let v = 1 << (a.length - 1);
    let wv = v << 1;
    let out = [wv];
    for (const c of a) {
        if (c == 'I') {
            wv += v;
        } else {
            wv -= v;
        }
        v >>= 1;
        out.push(wv);
    }
    let q = [...out];
    q.sort(function(a,b) {
        return a-b;
    });
    let c = new Map;
    q.forEach((v, i) => {c.set(v, i)});
    return out.map(x => c.get(x));
}

if (deepEqual(distringmatch('IDID'), [0, 4, 1, 3, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(distringmatch('III'), [0, 1, 2, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(distringmatch('DDI'), [3, 2, 0, 1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
