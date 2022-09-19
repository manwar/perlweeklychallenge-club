#! /usr/bin/node

"use strict"

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
    let m=m0;
    let n=n0;
    while (n != 0) {
        [m,n]=[n,m % n];
    }
    return m;
}

function eulertotient(n) {
    let et = 0;
    for (let k = 1; k <= n; k++) {
        if (gcd(n,k) == 1) {
            et++;
        }
    }
    return et;
}

function iteratedtotient(n0) {
    let p = 0;
    let n = n0;
    while (true) {
        n = eulertotient(n);
        p += n;
        if (n==1) {
            break;
        }
        if (p > n0) {
            break;
        }
    }
    return p;
}

function perfecttotient(ct) {
    let o = [];
    let n = 1;
    while (o.length < ct) {
        n++;
        if (iteratedtotient(n) == n) {
            o.push(n);
        }
    }
    return o;
}

if (deepEqual(perfecttotient(20),
              [3, 9, 15, 27, 39, 81, 111, 183, 243, 255, 327, 363,
               471, 729, 2187, 2199, 3063, 4359, 4375, 5571])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
