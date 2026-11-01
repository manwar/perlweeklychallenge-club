#! /usr/bin/node

"use strict"

function reflect(a) {
    let p = [];
    let am = a;
    while (true) {
        p.push(am % 2);
        am >>= 1;
        if (am == 0) {
            break;
        }
    }
    let ar = 0;
    let s = p.length;
    for (let n of p) {
        s -= 1;
        ar += n << s;
    }
    return ar;
}

function binaryreflection(ax) {
    const k = ax.map(x => reflect(x));
    let i = [];
    for (let n = 0; n < ax.length; n++) {
        i.push(n);
    }
    i.sort(function(a, b) {
        if (k[a] == k[b]) {
            return ax[a] - ax[b];
        } else {
            return k[a] - k[b];
        }
    });
    return i.map(x => ax[x]);
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

if (deepEqual(binaryreflection([3, 6, 12]), [3, 6, 12])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(binaryreflection([1, 2, 4, 8]), [1, 2, 4, 8])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(binaryreflection([7, 8, 9, 10]), [8, 10, 7, 9])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(binaryreflection([5, 9, 15, 17]), [5, 9, 15, 17])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(binaryreflection([11, 13, 14, 19]), [14, 13, 11, 19])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
