#! /usr/bin/node

"use strict"

function relativesort(list1, list2) {
    let c = new Map();
    for (let p of list1) {
        if (c.has(p)) {
            c.set(p,c.get(p)+1);
        } else {
            c.set(p,1);
        }
    }
    let out = [];
    for (let i of list2) {
        if (c.has(i)) {
            out.push(...Array(c.get(i)).fill(i));
            c.delete(i);
        }
    }
    var d = [...c.keys()];
    d.sort();
    for (let i of d) {
        out.push(...Array(c.get(i)).fill(i));
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

if (deepEqual(relativesort([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6]), [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(relativesort([3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2]), [1, 3, 3, 3, 2, 2, 4, 4, 6])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(relativesort([3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2]), [1, 1, 1, 0, 0, 3, 2, 4, 5])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
