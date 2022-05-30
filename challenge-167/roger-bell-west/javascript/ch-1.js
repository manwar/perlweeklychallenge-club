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

function cyclicpermute(n) {
    let ss = n.toString();
    let o = [];
    for (let p = 0; p < ss.length; p++) {
        ss = ss.slice(1,ss.length) + ss.slice(0,1)
        o.push(parseInt(ss));
    }
    return o;
}

function circular(mindigits,ct) {
    let o = [];
    let base = 1;
    for (let p = 2; p <= mindigits; p++) {
        base *= 10;
    }
    while (o.length < ct) {
        let pr = genprimes(base * 10);
        let prs = new Set(pr);
        for (let cp of pr) {
            if (cp >= base) {
                let v = true;
                let cpp = cyclicpermute(cp);
                for (let cpc of cpp) {
                    if (!prs.has(cpc)) {
                        v = false;
                        break;
                    }
                }
                if (v) {
                    o.push(cp);
                    if (o.size >= ct) {
                        break;
                    }
                    for (let cpc of cpp) {
                        prs.delete(cpc);
                    }
                }
            }
        }
        base *= 10;
    }
    return o;
}

if (deepEqual(cyclicpermute(123),[231, 312, 123])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(circular(3,10),[113, 197, 199, 337, 1193, 3779, 11939,
                              19937, 193939, 199933])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
