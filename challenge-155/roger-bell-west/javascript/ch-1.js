#! /usr/bin/node
function deepEqual(a,b)
{
    if( (typeof a == 'object' && a != null) &&
        (typeof b == 'object' && b != null) )
    {
        var count = [0,0]
        for( var key in a) count[0]++
        for( var key in b) count[1]++
        if( count[0]-count[1] != 0) {return false}
        for( var key in a)
        {
            if(!(key in b) || !deepEqual(a[key],b[key])) {return false}
        }
        for( var key in b)
        {
            if(!(key in a) || !deepEqual(b[key],a[key])) {return false}
        }
        return true
    }
    else
    {
        return a === b
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

function nthprimelimit(n) {
    let m=15;
    if (n >= 6) {
        m=Math.floor(1+n*Math.log(n*Math.log(n)));
    }
    return m
}

function isprime(candidate) {
    if (candidate==2) {
        return true
    } else if (candidate==3) {
        return true
    } else if (candidate % 2 == 0) {
        return false
    } else if (candidate % 3 == 0) {
        return false
    }
    anchor=0
    limit=Math.floor(Math.sqrt(candidate))
    while (1) {
        anchor+=6
        for (let t = anchor-1; t <= anchor+1; t += 2) {
            if (t > limit) {
                return true
            }
            if (candidate % t == 0) {
                return false
            }
        }
    }
}

function fortunate (ct) {
    let o=new Set()
    let ll=[]
    let ph=1
    for (let p of genprimes(nthprimelimit(ct*2))) {
        if (o.size >= ct) {
            if (p > Math.max(...o)) {
                break
            }
        }
        ph *= p
        let l = p + 1
        while (!isprime(l+ph)) {
            l++
        }
        o.add(l)
        if (o.size > ct) {
            ll=Array.from(o)
            ll.sort(function(a, b){return a-b})
            ll=ll.slice(0,ct)
            o=new Set(ll)
        }
    }
    return ll
}

if (deepEqual(fortunate(8),[3, 5, 7, 13, 17, 19, 23, 37])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
