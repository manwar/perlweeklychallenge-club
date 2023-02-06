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

function widestvalley(a) {
    let av = [];
    let ac = [];
    let l = -1;
    for (let v of a) {
        if (v == l) {
            ac[ac.length - 1]++;
        } else {
            av.push(v);
            ac.push(1);
            l = v;
        }
    }
    let s = [];
    let e = []
    let c = 0;
    for (let i = 0; i < av.length; i++) {
        if (i == 0 || i == av.length - 1 || (av[i - 1] < av[i] && av[i] > av[i + 1])) {
            s.push(c);
            e.push(c + ac[i] - 1);
        }
        c += ac[i];
    }
    let out = [];
    for (let i = 0; i < s.length - 1; i++) {
        if (e[i + 1] - s[i] + 1 > out.length) {
            out = a.slice(s[i], e[i + 1] + 1);
        }
    }
    return out;
}

if (deepEqual(widestvalley([1, 5, 5, 2, 8]), [5, 5, 2, 8])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(widestvalley([2, 6, 8, 5]), [2, 6, 8])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(widestvalley([9, 8, 13, 13, 2, 2, 15, 17]), [13, 13, 2, 2, 15, 17])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(widestvalley([2, 1, 2, 1, 3]), [2, 1, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(widestvalley([1, 3, 3, 2, 1, 2, 3, 3, 2]), [3, 3, 2, 1, 2, 3, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
