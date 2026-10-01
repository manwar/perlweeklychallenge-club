#! /usr/bin/node

"use strict"

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
    let mr=isqrt(mx);
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

function primestep(a) {
    const g = a.split("").map(c => c.charCodeAt(0)).reduce((x, y) => x + y);
    const pm = genprimes(g * 2);
    const lo = Math.max(...pm.filter(x => x <= g));
    const hi = Math.min(...pm.filter(x => x >= g));
    return Math.min(g - lo, hi - g);
}

if (primestep('hello') == 9) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (primestep('football') == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (primestep('a') == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (primestep('challenge') == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (primestep('perl') == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
