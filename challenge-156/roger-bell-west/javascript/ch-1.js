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

function hammingweight(x0) {
    let x=x0
    let count=0
    while (x > 0) {
        x &= (x-1)
        count++
    }
    return count
}

function pernicious(n) {
    let out=[]
    let c=1
    while (true) {
        if (isprime(hammingweight(c))) {
            out.push(c)
            if (out.length >= n) {
                break
            }
        }
        c++
    }
    return out
}

if (deepEqual(pernicious(10),[3, 5, 6, 7, 9, 10, 11, 12, 13, 14])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
