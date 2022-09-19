#! /usr/bin/node

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


function isnumpal(c0) {
    let c = c0
    let j = 0
    while (c > 0) {
        j = 10 * j + c % 10
        c = Math.floor(c / 10)
    }
    return (c0 == j)
}

function primepal(pmax) {
    return genprimes(pmax).filter(i => isnumpal(i))
}

if (deepEqual(primepal(1000), [2, 3, 5, 7, 11, 101, 131, 151, 181,
                               191, 313, 353, 373, 383, 727, 757, 787,
                               797, 919, 929])) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write("\n");
