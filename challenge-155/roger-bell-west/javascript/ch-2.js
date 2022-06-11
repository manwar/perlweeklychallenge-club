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
    for (let p of [2,3,5,7]) {
        while (m % p == 0) {
            m=Math.floor(m/p)
            if (f.has(p)) {
                f.set(p,f.get(p)+1)
            } else {
                f.set(p,1)
            }
        }
    }
    if (m > 1) {
        for (let p of genprimes(m)) {
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
    }
    return f
}

function gcd (m0,n0) {
    let m=m0
    let n=n0
    while (n != 0) {
        [m,n]=[n,m % n]
    }
    return m
}

function lcm (m,n) {
    return m/gcd(m,n)*n
}

function pisano (n) {
    let a=1
    primefactor(n).forEach((v,k) => {
        let nn=k ** v
        let t=1
        let x=[1,1]
        while (x[0]!=0 || x[1]!=1) {
            t++
            x=[x[1],(x[0]+x[1]) % nn]
        }
        a=lcm(a,t)
    })
    return a
}

if (pisano(3) == 8) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (pisano(6) == 24) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
