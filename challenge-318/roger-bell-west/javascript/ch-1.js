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

function groupposition(a) {
    let mx = [];
    let lc = "z";
    a.split("").forEach((c, i) => {
        if (i == 0) {
            lc = String.fromCharCode(c.charCodeAt(0) + 1);
        }
        if (lc == c) {
            const mc = mx.length;
            mx[mc - 1][1] += 1;
        } else {
            mx.push([c, 1]);
            lc = c;
        }
    });
    let out = [];
    for (let ms of mx) {
        if (ms[1] >= 3) {
            out.push(ms[0].repeat(ms[1]));
        }
    }
    return out;
}

if (deepEqual(groupposition('abccccd'), ['cccc'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(groupposition('aaabcddddeefff'), ['aaa', 'dddd', 'fff'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(groupposition('abcdd'), [])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
