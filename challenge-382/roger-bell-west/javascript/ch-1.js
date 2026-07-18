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

function isqrt(s) {
    if (s <= 1) {
        return s;
    } else {
        let x0 = s / 2;
        let x1 = Math.floor((x0 + Math.floor(s / x0)) / 2);
        while (x1 < x0) {
            x0 = x1;
            x1 = Math.floor((x0 + Math.floor(s / x0)) / 2);
        }
        return x0;
    }
}

function is_adjacentsquares(param, hc) {
    let hcs = [...hc];
    hcs.sort(function(a,b) {
        return a-b;
    });
    let tst = [];
    for (let i = 1; i <= param; i++) {
        tst.push(i);
    }
    if (!deepEqual(tst, hcs)) {
        console.log(hcs);
        console.log("bad hcs");
        return false;
    }
    for (let i = 0; i <= param - 2; i++) {
        const pn = hc[i] + hc[i + 1];
        const sn = isqrt(pn);
        if (pn != sn * sn) {
            console.log("bad pn");
            return false;
        }
    }
    const pn = hc[0] + hc[hc.length - 1];
    const sn = isqrt(pn * pn);
    if (pn != sn) {
        console.log("bad span");
        return false;
    }
    return true;
}

function hamiltoniancycle(a) {
    if (a < 31) {
        return [];
    }
    let perfectsquares = new Set();
    for (let p = 1; p <= a; p++) {
        perfectsquares.add(p * p);
    }
    let neighbours = new Map();
    for (let x = 1; x <= a; x++) {
        for (let y of perfectsquares) {
            if (y > x) {
                const z = y - x;
                if (z <= a) {
                    let s = new Set();
                    if (neighbours.has(x)) {
                        s = neighbours.get(x);
                    }
                    s.add(z);
                    neighbours.set(x, s);
                    s = new Set();
                    if (neighbours.has(z)) {
                        s = neighbours.get(z);
                    }
                    s.add(x);
                    neighbours.set(z, s);
                }
            }
        }
    }
    let stack = [];
    stack.push([1]);
    while (stack.length > 0) {
        const lst = stack.pop();
        if (lst.length == a) {
            if (perfectsquares.has(lst[0] + lst[lst.length - 1])) {
                return lst;
            }
        } else {
            let lh = new Set(lst);
            for (let candidate of neighbours.get(lst[lst.length - 1])) {
                if (!lh.has(candidate)) {
                    let nlst = [...lst];
                    nlst.push(candidate);
                    stack.push(nlst);
                }
            }
        }
    }
    return [];
}

if (deepEqual(is_adjacentsquares(32, hamiltoniancycle(32)), true)) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(hamiltoniancycle(15), [])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(is_adjacentsquares(34, hamiltoniancycle(34)), true)) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
