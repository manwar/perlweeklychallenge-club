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

// by VLAZ
// https://stackoverflow.com/a/59322890
function toWindows(inputArray, size) {
  return Array.from(
    {length: inputArray.length - (size - 1)}, //get the appropriate length
    (_, index) => inputArray.slice(index, index+size) //create the windows
  )
}

function shortestroute(r0, origin, destination) {
    let r = new Map();
    for (let rt of r0) {
        for (let rp of toWindows(rt, 2)) {
            if (!r.has(rp[0])) {
                r.set(rp[0], new Map());
            }
            r.set(rp[0], r.get(rp[0]).set(rp[1]));
            if (!r.has(rp[1])) {
                r.set(rp[1], new Map());
            }
            r.set(rp[1], r.get(rp[1]).set(rp[0]));
        }
    }
    let out = [];
    let stack = [ [ origin ] ];
    while (stack.length > 0) {
        const s = stack.shift();
        const l = s[s.length-1];
        if (l == destination) {
            out = s;
            break;
        } else {
            const s1 = new Set(s);
            for (let pd of r.get(l).keys()) {
                if (!s1.has(pd)) {
                    let q = [...s];
                    q.push(pd);
                    stack.push(q);
                }
            }
        }
    }
    return out;
}

if (deepEqual(shortestroute([[1, 2, 6], [5, 6, 7]], 1, 7), [1, 2, 6, 7])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(shortestroute([[1, 2, 3], [4, 5, 6]], 2, 5), [])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(shortestroute([[1, 2, 3], [4, 5, 6], [3, 8, 9], [7, 8]], 1, 7), [1, 2, 3, 8, 7])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
