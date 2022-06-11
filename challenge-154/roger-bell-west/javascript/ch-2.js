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

function padovanprime(ct) {
    pp=new Set
    padovans=[1,1,1]
    while (true) {
        padovans.push(padovans[0]+padovans[1])
        padovans.shift()
        if (isprime(padovans[2])) {
            pp.add(padovans[2])
            if (pp.size >= ct) {
                break
            }
        }
    }
    let out=[...pp]
    out.sort(function(a,b) {
        return a-b
    });
    return out
}

if (deepEqual(padovanprime(10),[2, 3, 5, 7, 37, 151, 3329, 23833,
                                13091204281, 3093215881333057])) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write("\n")

