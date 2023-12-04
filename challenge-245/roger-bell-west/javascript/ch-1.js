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

function sortlanguage(langs, popularities) {
    let ix = Array(langs.length).fill().map((element, index) => index);
    ix.sort(function(a,b) {
        return popularities[a] - popularities[b];
    });
    return ix.map(n => langs[n]);
}

if (deepEqual(sortlanguage(['perl', 'c', 'python'], [2, 1, 3]), ['c', 'perl', 'python'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(sortlanguage(['c++', 'haskell', 'java'], [1, 3, 2]), ['c++', 'java', 'haskell'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
