#! /usr/bin/node

"use strict"

function distributeelements(a) {
    let x = [a[0]];
    let y = [a[1]];
    a.slice(2).forEach(n => {
        if (x.at(-1) > y.at(-1)) {
            x.push(n);
        } else {
            y.push(n);
        }
    });
    x.push(...y);
    return x;
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

if (deepEqual(distributeelements([2, 1, 3, 4, 5]), [2, 3, 4, 5, 1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(distributeelements([3, 2, 4]), [3, 4, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(distributeelements([5, 4, 3, 8]), [5, 3, 4, 8])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
