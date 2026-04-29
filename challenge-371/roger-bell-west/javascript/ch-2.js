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
function combinations(arr, k) {
    let c = [];
    for (let i = 0; i < k; i++) {
        c.push(i);
    }
    c.push(arr.length);
    c.push(0);
    let out = [];
    while (true) {
        let inner = [];
        for (let i = k-1; i >= 0; i--) {
            inner.push(arr[c[i]]);
        }
        out.push(inner);
        let j = 0;
        while (c[j] + 1 == c[j + 1]) {
            c[j] = j;
            j += 1;
        }
        if (j >= k) {
            break;
        }
        c[j] += 1;
    }
    return out;
}

function subsetequilibrium(a) {
    let out = [];
    let b = [];
    let ix = [];
    for (let i = 0; i < a.length; i++) {
        ix.push(i);
        b.push(a[i] - i - 1);
    }
    for (let n = 1; n < b.length; n++) {
        for (let iyx of combinations(ix, n)) {
            let iy = iyx;
            iy.sort();
            const bp = iy.map(i => b[i]).reduce((x,y) => x+y);
            if (bp == 0) {
                const ap = iy.map(i => a[i]);
                out.push(ap);
            }
        }
    }
    out.sort();
    return out;
}

if (deepEqual(subsetequilibrium([2, 1, 4, 3]), [[1, 4], [2, 1], [2, 3], [4, 3]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(subsetequilibrium([3, 0, 3, 0]), [[3], [3, 0], [3, 0, 3]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(subsetequilibrium([5, 1, 1, 1]), [[5, 1, 1]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(subsetequilibrium([3, -1, 4, 2]), [[3, -1, 4], [3, 2]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(subsetequilibrium([10, 20, 30, 40]), [])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
