#! /usr/bin/node

"use strict"

function zeckendorfrepresentation(a) {
    let fib = [0, 1];
    while (fib[fib.length - 1] <= a) {
        fib.push(fib[fib.length - 1] + fib[fib.length - 2]);
    }
    fib.pop();
    let res = [];
    let aw = a;
    while (aw > 0) {
        const fl = fib.length - 1;
        res.push(fib[fl]);
        aw -= fib[fl];
        fib.pop();
        fib.pop();
        while (fib[fib.length - 1] > aw) {
            fib.pop();
        }
    }
    return res;
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

if (deepEqual(zeckendorfrepresentation(4), [3, 1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(zeckendorfrepresentation(12), [8, 3, 1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(zeckendorfrepresentation(20), [13, 5, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(zeckendorfrepresentation(96), [89, 5, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(zeckendorfrepresentation(100), [89, 8, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
