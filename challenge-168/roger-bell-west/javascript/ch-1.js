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

function isprime(candidate) {
    if (candidate<2) {
        return false
    } else if (candidate==2) {
        return true
    } else if (candidate==3) {
        return true
    } else if (candidate % 2 == 0) {
        return false
    } else if (candidate % 3 == 0) {
        return false
    }
    let anchor=0
    let limit=Math.floor(Math.sqrt(candidate))
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

function perrinprime(n) {
    let out = new Set;
    let seq = [3, 0, 2];
    while (true) {
        let nv = seq[0] + seq[1];
        seq.shift();
        seq.push(nv);
        if (isprime(nv)) {
            out.add(nv);
            if (out.size >= n) {
                break;
            }
        }
    }
    let o = [];
    for (let p of out) {
        o.push(p);
    }
    o.sort((a,b) => a-b);
    return o;
}

if (deepEqual(perrinprime(13),[2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193, 792606555396977])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
