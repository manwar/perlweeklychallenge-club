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

function omega(a, mode) {
    const pf = primefactor(a);
    if (mode == 0) {
        return pf.size;
    } else {
        return Array.of(...pf.values()).reduce((x, y) => x + y, 0);pf.values();
    }
}

if (omega(100061, 0) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (omega(971088, 0) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (omega(63640, 1) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (omega(988841, 1) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (omega(211529, 0) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
