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

function permute(a) {
    let out = [];
    let n=a.length;
    let c=[];
    for (let i = 0; i < n; i++) {
        c.push(0);
    }
    out.push([...a]);
    let i=0;
    while (true) {
        if (i >= n) {
            break;
        }
        if (c[i] < i) {
            if (i % 2 == 0) {
                [a[0],a[i]] = [a[i],a[0]];
            } else {
                [a[c[i]],a[i]] = [a[i],a[c[i]]];
            }
            out.push([...a]);
            c[i]++;
            i=0;
        } else {
            c[i]=0;
            i++;
        }
    }
    return out;
}

function nextpermutation(a) {
    let b = [...a];
    b.sort(function(aa, bb) {
        return aa - bb;
    });
    let flag = false;
    let out = [];
    let pp = permute(b);
    pp.sort(function(i, j) {
        let ix = 0;
        let res = 1;
        while (true) {
            if (ix >= i.length && ix >= j.length) {
                break;
            }
            if (ix < i.length && ix >= j.length) {
                res = 1;
                break;
            }
            if (ix >= i.length && ix < j.length) {
                res = -1;
                break;
            }
            if (i[ix] != j[ix]) {
                res = i[ix] - j[ix];
                break;
            }
            ix++;
        }
        return res
    });
    for (let px of pp) {
        if (out.length == 1) {
            out = px;
        }
        if (flag) {
            out = px
            flag = false;
        }
        if (deepEqual(px, a)) {
            flag = true;
        }
    }
    return out
}

if (deepEqual(nextpermutation([1, 2, 3]), [1, 3, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(nextpermutation([2, 1, 3]), [2, 3, 1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(nextpermutation([3, 1, 2]), [3, 2, 1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
