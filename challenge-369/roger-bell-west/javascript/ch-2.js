#! /usr/bin/node

"use strict"

function groupdivision(a0, sz, pad) {
    let a = a0;
    while (a.length % sz != 0) {
        a += pad;
    }
    let out = [];
    let i = 0;
    while (i < a.length) {
        out.push(a.slice(i, i + sz));
        i += sz;
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

if (deepEqual(groupdivision('RakuPerl', 4, '*'), ['Raku', 'Perl'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(groupdivision('Python', 5, '0'), ['Pytho', 'n0000'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(groupdivision('12345', 3, 'x'), ['123', '45x'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(groupdivision('HelloWorld', 3, '_'), ['Hel', 'loW', 'orl', 'd__'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(groupdivision('AI', 5, '!'), ['AI!!!'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
