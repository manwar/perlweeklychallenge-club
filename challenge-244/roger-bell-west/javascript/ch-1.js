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

function countsmaller(nums) {
    let b = [...nums];
    b.sort(function(a,b) {
        return a-b;
    });
    let sm = new Map;
    let l = 0;
    b.forEach((e, i) => {
        if (i == 0 || e != l) {
            sm.set(e, i);
            l = e;
        }
    });
    return nums.map(n => sm.get(n));
}

if (deepEqual(countsmaller([8, 1, 2, 2, 3]), [4, 0, 1, 1, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(countsmaller([6, 5, 4, 8]), [2, 1, 0, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(countsmaller([2, 2, 2]), [0, 0, 0])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
