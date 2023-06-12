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

// by VLAZ
// https://stackoverflow.com/a/59322890
function toWindows(inputArray, size) {
  return Array.from(
    {length: inputArray.length - (size - 1)}, //get the appropriate length
    (_, index) => inputArray.slice(index, index+size) //create the windows
  )
}

function squared(a) {
    return a * a;
}

function decode(a0, base) {
    let eq = [];
    let a = a0;
    while (a > 0) {
        eq.unshift(a % base);
        a = Math.trunc(a / base);
    }
    return eq;
}

function encode(sq, base) {
    let a = 0;
    for (let v of sq) {
        a *= base;
        a += v;
    }
    return a;
}

function squareful(lst) {
    let results = new Set();
    let squares = new Set();
    const base = Math.max(...lst) + 1;
    for (let la of permute(lst)) {
        let squareful = true;
        for (let a of toWindows(la, 2)) {
            const cs = a[0] + a[1];
            let mx = squared(squares.size);
            while (cs > mx) {
                mx = squared(squares.size + 1);
                squares.add(mx);
            }
            if (!squares.has(cs)) {
                squareful = false;
                break;
            }
        }
        if (squareful) {
            results.add(encode(la, base));
        }
    }
    let s = Array.from(results);
    s.sort(function(a,b) {
        return a-b;
    });
    return s.map(x => decode(x, base));
}

if (deepEqual(squareful([1, 17, 8]), [[1, 8, 17], [17, 8, 1]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(squareful([2, 2, 2]), [[2, 2, 2]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
