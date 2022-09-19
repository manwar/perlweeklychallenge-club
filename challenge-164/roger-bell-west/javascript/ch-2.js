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

function ssd(n0) {
    let n = n0
    let out = 0
    while (n > 0) {
        let d = n % 10
        out += d * d
        n=Math.floor(n/10)
    }
    return out
}

function happy(ct) {
    let hm = new Map([[1, true]])
    let c = 0
    let out = []
    while (true) {
        c++
        if (!hm.has(c)) {
            let v = c
            let ss = new Set([v])
            let h = true
            while (true) {
                if (hm.has(v)) {
                    h = hm.get(v)
                    break
                } else {
                    v = ssd(v)
                    if (ss.has(v)) {
                        h = false
                        break
                    }
                    ss.add(v)
                }
            }
            ss.forEach(i => hm.set(i,h))
        }
        if (hm.get(c)) {
            out.push(c)
            if (out.length >= ct) {
                break
            }
        }
    }
    return out
}

if (deepEqual(happy(8), [1, 7, 10, 13, 19, 23, 28, 31])) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write("\n");
