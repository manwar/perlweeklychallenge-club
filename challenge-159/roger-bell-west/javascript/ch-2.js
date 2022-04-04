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
    for (let p of genprimes(Math.floor(Math.sqrt(n)))) {
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

function moebius (n) {
    let z=0
    for (let v of primefactor(n).values()) {
        if (v > 1) {
            return 0
        }
        z++
    }
    if (z % 2 == 0) {
        return 1
    }
    return -1
}

if (moebius(5) == -1) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (moebius(10) == 1) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (moebius(20) == 0) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
