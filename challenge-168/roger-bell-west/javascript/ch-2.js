#! /usr/bin/node

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

function primefactor (n) {
    let f=new Map()
    let m=n
    for (let p of genprimes(1+Math.floor(Math.sqrt(n)))) {
        while (m % p == 0) {
            m=Math.floor(m/p)
            if (f.has(p)) {
                f.set(p,f.get(p)+1)
            } else {
                f.set(p,1)
            }
            if (m == 1) {
                break
            }
        }
    }
    if (m > 1) {
        if (f.has(m)) {
            f.set(m,f.get(m)+1)
        } else {
            f.set(m,1)
        }
    }
    return f
}

function homeprime (n0) {
    let n = n0;
    while (true) {
        let t = primefactor(n);
        if (t.size == 1 && [...t.values()][0] == 1) {
            break;
        }
        let ns = "";
        let tk = [...t.keys()];
        tk.sort((a,b) => a-b);
        for (let d of tk) {
            for (let i=0; i<t.get(d); i++) {
                ns = ns.concat(d);
            }
        }
        n = parseInt(ns);
    }
    return n;
}

if (homeprime(10) == 773) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (homeprime(16) == 31636373) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
