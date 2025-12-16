#! /usr/bin/node

"use strict"

function matchstring(a) {
    let out = [];
    let s = new Set;
    for (let x of a) {
        if (!s.has(x)) {
            for (let y of a) {
                if (y.length > x.length && y.indexOf(x) >= 0) {
                    out.push(x);
                    break;
                }
            }
            s.add(x);
        }
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

if (deepEqual(matchstring(['cat', 'cats', 'dog', 'dogcat', 'dogcat', 'rat', 'ratcatdogcat']), ['cat', 'dog', 'dogcat', 'rat'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(matchstring(['hello', 'hell', 'world', 'wor', 'ellow', 'elloworld']), ['hell', 'world', 'wor', 'ellow'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(matchstring(['a', 'aa', 'aaa', 'aaaa']), ['a', 'aa', 'aaa'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(matchstring(['flower', 'flow', 'flight', 'fl', 'fli', 'ig', 'ght']), ['flow', 'fl', 'fli', 'ig', 'ght'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(matchstring(['car', 'carpet', 'carpenter', 'pet', 'enter', 'pen', 'pent']), ['car', 'pet', 'enter', 'pen', 'pent'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
