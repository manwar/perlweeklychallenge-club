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

function mergeitems(a, b) {
    let c = new Map;
    for (let v of [a, b]) {
        for (let w of v) {
            if (!c.has(w[0])) {
                c.set(w[0], 0);
            }
            c.set(w[0], c.get(w[0]) + w[1]);
        }
    }
    let k = [...c.keys()];
    k.sort();
    return k.map(x => [x, c.get(x) ]);
}

if (deepEqual(mergeitems([[1, 1], [2, 1], [3, 2]], [[2, 2], [1, 3]]), [[1, 4], [2, 3], [3, 2]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(mergeitems([[1, 2], [2, 3], [1, 3], [3, 2]], [[3, 1], [1, 3]]), [[1, 8], [2, 3], [3, 3]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(mergeitems([[1, 1], [2, 2], [3, 3]], [[2, 3], [2, 4]]), [[1, 1], [2, 9], [3, 3]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
