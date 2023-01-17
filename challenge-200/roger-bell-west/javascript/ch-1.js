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

function arithmeticslices(l) {
    let o = [];
    if (l.length >= 3) {
        for (let a = 0; a <= l.length - 3; a++) {
            let valid = false;
            for (let b = a + 2; b <= l.length - 1; b++) {
                let v = l.slice(a, b + 1);
                if (!valid) {
                    for (let i = 0; i <= v.length - 3; i++) {
                        if (v[i + 1] - v[i] == v[i + 2] - v[i + 1]) {
                            valid = true;
                            break;
                        }
                    }
                }
                if (valid) {
                    o.push(v);
                }
            }
        }
    }
    return o;
}

if (deepEqual(arithmeticslices([1, 2, 3, 4]), [[1, 2, 3], [1, 2, 3, 4], [2, 3, 4]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(arithmeticslices([2]), [])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
