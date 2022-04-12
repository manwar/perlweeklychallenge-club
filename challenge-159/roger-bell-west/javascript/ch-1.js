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

function gcd (m0,n0) {
    let m=m0
    let n=n0
    while (n != 0) {
        [m,n]=[n,m % n]
    }
    return m
}

function lcm (m,n) {
    return m/gcd(m,n)*n
}

function lcmseries(a0,b) {
    let a=a0
    for (let i=a+1;i <= b;i++) {
        a=lcm(a,i)
    }
    return a
}

function farey (n) {
    let l=lcmseries(2,n)
    let d=new Map()
    let s=[]
    for (let i=1;i <= n;i++) {
        let m=l/i
        for (let j=0;j <= i;j++) {
            let k=m*j
            if (!d.has(k)) {
                d.set(k,[j,i])
                s.push(k)
            }
        }
    }
    s.sort(function(a,b) {
        return a-b;
    })
    return s.map(i => d.get(i))
}

if (deepEqual(farey(5),[
    [0, 1], [1, 5], [1, 4], [1, 3], [2, 5], [1, 2], [3, 5], [2, 3],
    [3, 4], [4, 5], [1, 1]
])) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write(" ");

if (deepEqual(farey(7),[
    [0, 1], [1, 7], [1, 6], [1, 5], [1, 4], [2, 7], [1, 3], [2, 5],
    [3, 7], [1, 2], [4, 7], [3, 5], [2, 3], [5, 7], [3, 4], [4, 5],
    [5, 6], [6, 7], [1, 1]
])) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write(" ");

if (deepEqual(farey(4),[
    [0, 1], [1, 4], [1, 3], [1, 2], [2, 3], [3, 4], [1, 1]
])) {
    process.stdout.write("Pass")
} else {
    process.stdout.write("FAIL")
}
process.stdout.write("\n");
