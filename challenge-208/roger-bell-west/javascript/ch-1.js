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

function v2hm(a) {
    let h = new Map();
    a.forEach((x, i) => {
        if (!h.has(x)) {
            h.set(x, i);
        }
    });
    return h;
}

function minindexsum(a, b) {
    let ah = v2hm(a);
    let bh = v2hm(b);
    let out = [];
    let mi = a.length + b.length;
    for (let w of a) {
        if (bh.has(w)) {
            let mv = ah.get(w) + bh.get(w);
            if (mv < mi) {
                out = [];
                mi = mv;
            }
            if (mv == mi) {
                out.push(w);
            }
        }
    }
    return out;
}

if (deepEqual(minindexsum(['Perl', 'Raku', 'Love'], ['Raku', 'Perl', 'Hate']), ['Perl', 'Raku'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(minindexsum(['A', 'B', 'C'], ['D', 'E', 'F']), [])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(minindexsum(['A', 'B', 'C'], ['C', 'A', 'B']), ['A'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
