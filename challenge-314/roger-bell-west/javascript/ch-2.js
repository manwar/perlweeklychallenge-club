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

function sortcolumn(a) {
    let vv = [];
    a.forEach((s, i) => {
        s.split("").forEach((c, j) => {
            if (i == 0) {
                vv.push([]);
            }
            vv[j].push(c);
        });
    });
    let tot = 0;
    for (let x of vv) {
        let y = [...x];
        y.sort();
        if (!deepEqual(x, y)) {
            tot += 1;
        }
    }
    return tot;
}

if (sortcolumn(['swpc', 'tyad', 'azbe']) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sortcolumn(['cba', 'daf', 'ghi']) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (sortcolumn(['a', 'b', 'c']) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
