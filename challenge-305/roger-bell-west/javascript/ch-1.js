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

function is_prime(candidate) {
    if (candidate<2) {
        return false
    } else if (candidate==2) {
        return true
    } else if (candidate==3) {
        return true
    } else if (candidate % 2 == 0) {
        return false
    } else if (candidate % 3 == 0) {
        return false
    }
    let anchor=0
    let limit=Math.floor(Math.sqrt(candidate))
    while (1) {
        anchor+=6
        for (let t = anchor-1; t <= anchor+1; t += 2) {
            if (t > limit) {
                return true
            }
            if (candidate % t == 0) {
                return false
            }
        }
    }
}

function binaryprefix(a) {
    let out = [];
    let n = 0;
    for (let x of a) {
        n *= 2
        if (x == 1) {
            n += 1;
        }
        out.push(is_prime(n));
    }
    return out;
}

if (deepEqual(binaryprefix([1, 0, 1]), [false, true, true])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(binaryprefix([1, 1, 0]), [false, true, false])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(binaryprefix([1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1]), [false, true, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, true])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
