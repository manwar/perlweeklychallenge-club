#! /usr/bin/node

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
    let m=m0
    let n=n0
    while (n != 0) {
        [m,n]=[n,m % n]
    }
    return m
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

function achilles(ct) {
    let out = [];
    let n = 1;
    while (true) {
        n++;
        let pv = [...primefactor(n).values()];
        if (pv.length > 1 &&
            Math.min(...pv) >= 2 &&
            pv.reduce((acc, x) => gcd(acc,x),pv[0]) == 1) {
            out.push(n);
            if (out.length >= ct) {
                break;
            }
        }
    }
    return out;
}

if (deepEqual(achilles(20),[72, 108, 200, 288, 392, 432, 500, 648,
                            675, 800, 864, 968, 972, 1125, 1152, 1323,
                            1352, 1372, 1568, 1800])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
