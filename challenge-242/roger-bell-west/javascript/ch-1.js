#! /usr/bin/node

"use strict"

function unique(a) {
    let ss = new Set;
    let b = [];
    for (let i of a) {
        if (!ss.has(i)) {
            b.push(i);
            ss.add(i);
        }
    }
    return b;
}

function halfmissing(a, bh) {
    return unique(a.filter(n => !bh.has(n)))
}

function missingmembers(a, b) {
    const ah = new Set(a);
    const bh = new Set(b);
    return [halfmissing(a, bh), halfmissing(b, ah)];
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

if (deepEqual(missingmembers([1, 2, 3], [2, 4, 6]), [[1, 3], [4, 6]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(missingmembers([1, 2, 3, 3], [1, 1, 2, 2]), [[3], []])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
