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

function numbercollision(aa) {
    let a = aa;
    let dirty = true;
    while (dirty) {
        let b = [];
        dirty = false;
        let i = 0;
        while (i + 1 <= a.length) {
            if (i + 1 < a.length && a[i] > 0 && a[i + 1] < 0) {
                let ab = Math.abs(a[i + 1]);
                if (a[i] > ab) {
                    b.push(a[i]);
                } else if (a[i] < ab) {
                    b.push(a[i + 1]);
                }
                i += 2;
                dirty = true;
            } else {
                b.push(a[i]);
                i += 1;
            }
        }
        a = b;
    }
    return a;
}

if (deepEqual(numbercollision([2, 3, -1]), [2, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(numbercollision([3, 2, -4]), [-4])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(numbercollision([1, -1]), [])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
