#! /usr/bin/node

"use strict"

function range(from, to) {
    let a = new Array(to - from + 1);
    for (let i = from; i <= to; i++) {
        a[i - from] = i;
    }
    return a;
}

function rightinterval(a) {
    const ss = a.map(x => x[0]);
    let si = range(0, a.length - 1);
    si.sort(function(aa, bb) {
        return ss[aa] - ss[bb];
    });
    let out = [];
    for (let l of a) {
        const ix = si.filter(i => ss[i] >= l[1]);
        if (ix.length == 0) {
            out.push(-1)
        } else {
            out.push(ix[0]);
        }
    }
    return out;
}

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

if (deepEqual(rightinterval([[3, 4], [2, 3], [1, 2]]), [-1, 0, 1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(rightinterval([[1, 4], [2, 3], [3, 4]]), [-1, 2, -1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(rightinterval([[1, 2]]), [-1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(rightinterval([[1, 4], [2, 2], [3, 4]]), [-1, 1, -1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
