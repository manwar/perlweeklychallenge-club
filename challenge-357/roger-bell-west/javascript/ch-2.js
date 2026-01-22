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

function gcd (m0,n0) {
    let m=m0;
    let n=n0;
    while (n != 0) {
        [m,n]=[n,m % n];
    }
    return m;
}

function uniquefractiongenerator(a) {
    let den = 1;
    for (let dn = 2; dn <= a; dn++) {
        den *= dn;
    }
    let f = new Set();
    for (let d = 1; d <= a; d++) {
        let nd = Math.floor(den / d);
        for (let n = 1; n <= a; n++) {
            f.add(n * nd);
        }
    }
    let out = []
    let ff = [...f];
    ff.sort(function(a,b) {
        return a-b;
    });
    for (let n of ff) {
        let g = gcd(n, den);
        let nn = Math.floor(n / g);
        let nd = Math.floor(den / g);
        out.push(nn.toString() + "/" + nd.toString());
    }
    return out;
}

if (deepEqual(uniquefractiongenerator(3), ['1/3', '1/2', '2/3', '1/1', '3/2', '2/1', '3/1'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(uniquefractiongenerator(4), ['1/4', '1/3', '1/2', '2/3', '3/4', '1/1', '4/3', '3/2', '2/1', '3/1', '4/1'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(uniquefractiongenerator(1), ['1/1'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(uniquefractiongenerator(6), ['1/6', '1/5', '1/4', '1/3', '2/5', '1/2', '3/5', '2/3', '3/4', '4/5', '5/6', '1/1', '6/5', '5/4', '4/3', '3/2', '5/3', '2/1', '5/2', '3/1', '4/1', '5/1', '6/1'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(uniquefractiongenerator(5), ['1/5', '1/4', '1/3', '2/5', '1/2', '3/5', '2/3', '3/4', '4/5', '1/1', '5/4', '4/3', '3/2', '5/3', '2/1', '5/2', '3/1', '4/1', '5/1'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
