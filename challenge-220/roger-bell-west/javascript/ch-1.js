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

function word2set(word) {
    let r = new Set();
    for (let c of word.toLowerCase()) {
        if (c >= 'a' && c <= 'z') {
            r.add(c);
        }
    }
    return r
}

function commoncharacters(lst) {
    let c = word2set(lst[0]);
    for (let w of lst.slice(1)) {
        const d = word2set(w);
        for (let l of c) {
            if (!d.has(l)) {
                c.delete(l);
            }
        }
    }
    let s = Array.from(c);
    s.sort();
    return s;
}

if (deepEqual(commoncharacters(['Perl', 'Rust', 'Raku']), ['r'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(commoncharacters(['love', 'live', 'leave']), ['e', 'l', 'v'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
