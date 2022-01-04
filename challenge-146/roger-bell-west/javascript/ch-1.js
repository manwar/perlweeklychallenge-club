#! /usr/bin/node

function genprimes(mx) {
    let primesh=new Set([2,3]);
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

function nthprime(n) {
    let m=15;
    if (n >= 6) {
        m=Math.floor(1+n*Math.log(n*Math.log(n)));
    }
    let p=genprimes(m);
    return p[n-1];
}

if (nthprime(10001) === 104743) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");

