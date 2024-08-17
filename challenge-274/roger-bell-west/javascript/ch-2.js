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

function busroute(a) {
    let route = [];
    for (let rt of a) {
        let ri = new Map;
        const interval = rt[0];
        const offset = rt[1];
        const duration = rt[2];
        let start = offset;
        while (true) {
            if (start > 60 + offset) {
                break;
            }
            ri.set(start, start + duration);
            start += interval;
        }
        route.push(ri);
    }
    let out = [];
    for (let t = 0; t < 60; t++) {
        let best = new Set;
        let at = -1;
        let nxt = new Set;
        let ndt = -1;
        route.forEach((r, i) => {
            const nb = Math.min(...([...r.keys()].filter(n => n >= t)));
            const nt = r.get(nb);
            if (at == -1 || nt < at) {
                best = new Set;
                at = nt;
            }
            if (nt <= at) {
                best.add(i);
            }
            if (ndt == -1 || nb < ndt) {
                nxt = new Set;
                ndt = nb;
            }
            if (nb <= ndt) {
                nxt.add(i);
            }
        });
        const intersect = new Set([...best].filter(i => nxt.has(i)));
        if (intersect.size == 0) {
            out.push(t);
        }
    }
    return out;
}


if (deepEqual(busroute([[12, 11, 41], [15, 5, 35]]), [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(busroute([[12, 3, 41], [15, 9, 35], [30, 5, 25]]), [0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
