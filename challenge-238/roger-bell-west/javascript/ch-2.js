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

function persistence(a) {
    let steps = 0;
    let b = a;
    while (b > 9) {
        steps++;
        let p = 1;
        while (b > 0) {
            p *= b % 10;
            b = Math.trunc(b / 10);
        }
        b = p;
    }
    return steps;
}

function persistencearray(a) {
    let b = a;
    let c = new Map;
    for (let n of a) {
        c.set(n, persistence(n));
    }
    b.sort(function(aa, bb) {
        if (c.get(aa) == c.get(bb)) {
            return aa - bb;
        } else {
            return c.get(aa) - c.get(bb);
        }
    });
    return b;
}
    
if (deepEqual(persistencearray([15, 99, 1, 34]), [1, 15, 34, 99])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(persistencearray([50, 25, 33, 22]), [22, 33, 50, 25])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
