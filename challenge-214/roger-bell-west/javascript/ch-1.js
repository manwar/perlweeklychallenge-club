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

function rankscore(a) {
    let av = new Map;
    for (let s of a) {
        if (av.has(s)) {
            av.set(s, av.get(s) + 1);
        } else {
            av.set(s, 1);
        }
    }
    let kk = Array.from(av.keys());
    kk.sort(function(a,b) {
        return b-a;
    });
    let rank = 1;
    let tab = new Map;
    for (let k of kk) {
        const siz = av.get(k);
        let r = "";
        if (rank <= 3) {
            r = ["G", "S", "B"][rank - 1];
        } else {
            r = rank.toString();
        }
        if (siz > 1) {
            r += "=";
        }
        tab.set(k, r);
        rank += siz;
    }
    return a.map(i => tab.get(i));
}


if (deepEqual(rankscore([1, 2, 4, 3, 5]), ['5', '4', 'S', 'B', 'G'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(rankscore([8, 5, 6, 7, 4]), ['G', '4', 'B', 'S', '5'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(rankscore([3, 5, 4, 2]), ['B', 'G', 'S', '4'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(rankscore([2, 5, 2, 1, 7, 5, 1]), ['4=', 'S=', '4=', '6=', 'G', 'S=', '6='])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
