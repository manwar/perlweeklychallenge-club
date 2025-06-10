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

function finalprice(a) {
    let out = [];
    a.forEach((n, i) => {
        let discount = 0;
        for (let mi = i + 1; mi < a.length; mi++) {
            if (a[mi] <= n) {
                discount = a[mi];
                break;
            }
        }
        out.push(n - discount);
    });
    return out;
}

if (deepEqual(finalprice([8, 4, 6, 2, 3]), [4, 2, 4, 2, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(finalprice([1, 2, 3, 4, 5]), [1, 2, 3, 4, 5])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(finalprice([7, 1, 1, 5]), [6, 0, 1, 5])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
