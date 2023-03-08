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

function keyboardword(wl) {
    let re = /^([qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$/i;
    let out = []
    for (let w of wl) {
        if (w.search(re) > -1) {
            out.push(w);
        }
    }
    return out;
}

if (deepEqual(keyboardword(['Hello', 'Alaska', 'Dad', 'Peace']), ['Alaska', 'Dad'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(keyboardword(['OMG', 'Bye']), [])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
