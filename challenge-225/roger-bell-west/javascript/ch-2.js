#! /usr/bin/node

"use strict"

function leftrightsumdiff(a) {
    const al = a.length - 1;
    let left = [0];
    let right = [0];
    for (let i = 0; i < al; i++) {
        left.push(left[i] + a[i]);
        right.push(right[i] + a[al - i]);
    }
    right.reverse();
    let out = [];
    for (let i = 0; i <= al; i++) {
        out.push(Math.abs(left[i] - right[i]));
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

if (deepEqual(leftrightsumdiff([10, 4, 8, 3]), [15, 1, 11, 22])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(leftrightsumdiff([1]), [0])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(leftrightsumdiff([1, 2, 3, 4, 5]), [14, 11, 6, 1, 10])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
