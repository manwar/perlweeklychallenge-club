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

function genprimes(mx) {
    let primesh=new Set([2,3]);
    for (let i = 6; i <= mx+1; i += 6) {
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

function tos(n) {
    return n.toString();
}

function ltruncprimes(count) {
    let out=[];
    let lt=0;
    let p=genprimes(500).map(tos);
    let pp=new Set(p);
    for (let pc of p) {
        let l=pc.length;
        let c=true;
        for (let i=1;i<l;i++) {
            if (!pp.has(pc.slice(i))) {
                c=false;
                break;
            }
        }
        if (c) {
            out.push(parseInt(pc));
            lt++;
            if (lt >= count) {
                break;
            }
        }
    }
    return out;
}

if (deepEqual(ltruncprimes(20),[2, 3, 5, 7, 13, 17, 23, 37, 43, 47, 53, 67, 73, 83, 97, 113, 137, 167, 173, 197])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");

