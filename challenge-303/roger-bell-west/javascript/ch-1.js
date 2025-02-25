#! /usr/bin/node

"use strict"

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

function concatenate(a) {
    return parseInt(a.join(""));
}

function threedigitseven(a) {
    let s = new Set;
    for (let mask = 1; mask < (1 << a.length); mask++) {
        let pl = []
        a.forEach((x, i) => {
            if ((mask & (1 << i)) > 0) {
                pl.push(x);
            }
        });
        for (let px of permute(pl)) {
            const c = concatenate(px)
            if (c >= 100 && c <= 999 && c % 2 == 0) {
                s.add(c)
            }
        }
    }
    let out = [...s];
    out.sort(function(aa, bb) {
        return aa - bb;
    });
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

if (deepEqual(threedigitseven([2, 1, 3, 0]), [102, 120, 130, 132, 210, 230, 302, 310, 312, 320])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(threedigitseven([2, 2, 8, 8, 2]), [222, 228, 282, 288, 822, 828, 882])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
