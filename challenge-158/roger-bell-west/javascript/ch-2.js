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

function digitsum (x0) {
    let s=0
    let x=x0
    while (x > 0) {
        s += x % 10
        x = Math.trunc(x/10)
    }
    return s
}

function cuban1 (mx) {
    let o=[]
    let ps=new Set(genprimes(mx))
    for (let y=1; y <= mx; y++) {
        let q=3*y*(y+1)+1
        if (q > mx) {
            break
        }
        if (ps.has(q)) {
            o.push(q)
        }
    }
    return o
}

if (deepEqual(cuban1(1000),[7, 19, 37, 61, 127, 271, 331, 397, 547,
                            631, 919])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
