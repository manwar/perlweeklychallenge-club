#! /usr/bin/node

"use strict"

function sortoddeven(a) {
    let odds = [];
    let evens = [];
    a.forEach((x, i) => {
        if (i % 2 == 0) {
            evens.push(x);
        } else {
            odds.push(x);
        }
    });
    evens.sort(function(a,b) {
        return a-b;
    });
    odds.sort(function(a,b) {
        return b-a;
    });
    let out = [];
    for (let i = 0; i < Math.max(evens.length, odds.length); i++) {
        if (i < evens.length) {
            out.push(evens[i]);
        }
        if (i < odds.length) {
            out.push(odds[i]);
        }
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

if (deepEqual(sortoddeven([4, 1, 2, 3]), [2, 3, 4, 1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(sortoddeven([3, 1]), [3, 1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(sortoddeven([5, 3, 2, 1, 4]), [2, 3, 4, 1, 5])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
