#! /usr/bin/node

"use strict"

function getlistset(a) {
    let la = a.split(" ");
    let ca = new Map;
    for (let w of la) {
        if (ca.has(w)) {
            ca.set(w, ca.get(w) + 1);
        } else {
            ca.set(w, 1);
        }
    }
    la = la.filter(w => ca.get(w) == 1);
    const cb = new Set(ca.keys());
    return [la, cb];
}

function uncommonwords(a, b) {
    const [la, sa] = getlistset(a);
    const [lb, sb] = getlistset(b);
    let out = [];
    for (let [wl, t] of [[la, sb], [lb, sa]]) {
        for (let w of wl) {
            if (!t.has(w)) {
                out.push(w);
            }
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

if (deepEqual(uncommonwords('Mango is sweet', 'Mango is sour'), ['sweet', 'sour'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(uncommonwords('Mango Mango', 'Orange'), ['Orange'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(uncommonwords('Mango is Mango', 'Orange is Orange'), [])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
