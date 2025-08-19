#! /usr/bin/node

"use strict"

function commoncharacters(a) {
    let mc = new Map;
    let first = true;
    for (let s of a) {
        const mk = counterify(s.split(""));
        if (first) {
            mc = mk;
            first = false;
        } else {
            for (let k of mc.keys()) {
                if (mk.has(k)) {
                    mc.set(k, Math.min(mc.get(k), mk.get(k)));
                } else {
                    mc.delete(k);
                }
            }
        }
    }
    let out = [];
    let kl = [...mc.keys()];
    kl.sort();
    for (let c of kl) {
        for (let n = 1; n <= mc.get(c); n++) {
            out.push(c);
        }
    }
    return out;
}

function counterify(a) {
    let cc = new Map;
    for (let x of a) {
        if (!cc.has(x)) {
            cc.set(x, 0);
        }
        cc.set(x, cc.get(x) + 1);
    }
    return cc;
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

if (deepEqual(commoncharacters(['bella', 'label', 'roller']), ['e', 'l', 'l'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(commoncharacters(['cool', 'lock', 'cook']), ['c', 'o'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(commoncharacters(['hello', 'world', 'pole']), ['l', 'o'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(commoncharacters(['abc', 'def', 'ghi']), [])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(commoncharacters(['aab', 'aac', 'aaa']), ['a', 'a'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
