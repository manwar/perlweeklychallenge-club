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

function range(from, to) {
    let a = new Array(to - from + 1);
    for (let i = from; i <= to; i++) {
        a[i - from] = i;
    }
    return a;
}

function rearrangegroups(list, size) {
    let h = new Map();
    for (let k of list) {
        if (h.has(k)) {
            h.set(k, h.get(k) + 1);
        } else {
            h.set(k, 1);
        }
    }
    let out = [];
    while (true) {
        let m = Math.min(...h.keys());
        let res = range(m, m + size - 1);
        for (let n of res) {
            if (h.has(n)) {
                let p = h.get(n) - 1;
                if (p == 0) {
                    h.delete(n);
                } else {
                    h.set(n, p);
                }
            } else {
                return [];
            }
        }
        out.push(res);
        if (h.size == 0) {
            break;
        }
    }
    return out;
}

if (deepEqual(rearrangegroups([1, 2, 3, 5, 1, 2, 7, 6, 3], 3), [[1, 2, 3], [1, 2, 3], [5, 6, 7]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(rearrangegroups([1, 2, 3], 2), [])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(rearrangegroups([1, 2, 4, 3, 5, 3], 3), [[1, 2, 3], [3, 4, 5]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(rearrangegroups([1, 5, 2, 6, 4, 7], 3), [])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
