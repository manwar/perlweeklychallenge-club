#! /usr/bin/node

"use strict"

function genprimes(mx) {
    let primesh=new Set([2,3])
    for (let i = 6; i <= mx; i += 6) {
        for (let j = i-1; j <= i+1; j += 2) {
            if (j <= mx) {
                primesh.add(j);
            }
        }
    }
    let q=[2,3,5,7];
    let p=q.shift();
    let mr=Math.floor(Math.sqrt(mx));
    while (p <= mr) {
        if (primesh.has(p)) {
            let i=p*p
            for (let i=p*p; i <= mx; i += p) {
                primesh.delete(i);
            }
        }
        if (q.length < 2) {
            q.push(q[q.length-1]+4);
            q.push(q[q.length-1]+2);
        }
        p=q.shift();
    }
    let primes=[...primesh];
    primes.sort(function(a,b) {
        return a-b;
    });
    return primes;
}

function primefactor(n) {
    let f=new Map();
    let m=n;
    for (let p of genprimes(1+Math.floor(Math.sqrt(n)))) {
        while (m % p == 0) {
            m=Math.floor(m/p);
            if (f.has(p)) {
                f.set(p,f.get(p)+1);
            } else {
                f.set(p,1);
            }
            if (m == 1) {
                break;
            }
        }
    }
    if (m > 1) {
        if (f.has(m)) {
            f.set(m,f.get(m)+1);
        } else {
            f.set(m,1);
        }
    }
    return f;
}

function primefactorcount(n) {
    return Array.of(...primefactor(n).values()).reduce((x, y) => x + y, 0);
}

function primeorder(ints) {
    let b = ints;
    let c = new Map;
    for (let n of ints) {
        c.set(n, primefactorcount(n));
    }
    b.sort(function(aa, bb) {        if (c.get(aa) == c.get(bb)) {
        return aa - bb;
    } else {
        return c.get(aa) - c.get(bb);
    }
                            });
    return b;
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

if (deepEqual(primeorder([11, 8, 27, 4]), [11, 4, 8, 27])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
