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

function commoncharacters(a) {
    let ac = [];
    for (let w of a) {
        let h = new Map();
        for (let c of w.split("")) {
            if (h.has(c)) {
                h.set(c, h.get(c) + 1);
            } else {
                h.set(c, 1);
            }
        }
        ac.push(h);
    }
    let vc = new Map();
    for (let i = 0; i < ac.length; i++) {
        if (i == 0) {
            for (let c of ac[i].keys()) {
                vc.set(c, ac[i].get(c));
            }
        } else {
            for (let c of vc.keys()) {
                if (ac[i].has(c)) {
                    vc.set(c, Math.min(vc.get(c), ac[i].get(c)));
                } else {
                    vc.delete(c);
                }
            }
        }
    }
    let out = [];
    for (let c of a[0].split("")) {
        if (vc.has(c)) {
            out.push(c);
            vc.set(c, vc.get(c) - 1);
            if (vc.get(c) == 0) {
                vc.delete(c);
            }
        }
    }
    return out;
}

if (deepEqual(commoncharacters(['java', 'javascript', 'julia']), ['j', 'a'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
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
process.stdout.write("\n");
