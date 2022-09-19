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

function permutation2rank(perm) {
    let n = 0;
    let pp = [...perm];
    pp.sort(function(a,b) {
        return a-b;
    });
    let oi = [];
    let l = 1;
    for (let index = 2; index <= perm.length; index++) {
        oi.push(l);
        l *= index;
    }
    oi.reverse();
    for (let index=0; index <= perm.length-2; index++) {
        let base = new Map();
        for (let i=0; i < pp.length; i++) {
            base.set(pp[i],i);
        }
        n += oi[index] * base.get(perm[index]);
        base.delete(perm[index]);
        pp = [...base.keys()];
        pp.sort(function(a,b) {
            return a-b;
        });
    }
    return n;
}

function rank2permutation(perm, rank0) {
    let rank = rank0;
    let pp = [...perm];
    pp.sort(function(a,b) {
        return a-b;
    });
    let o = [];
    let oi = [];
    let l = 1;
    for (let index = 2; index <= perm.length; index++) {
        oi.push(l);
        l *= index;
    }
    oi.reverse();
    for (let index=0; index <= perm.length-2; index++) {
        let ix = Math.floor(rank / oi[index]);
        o.push(pp[ix]);
        pp = pp.filter(x => x != pp[ix]);
        rank %= oi[index];
    }
    o.push(pp[0]);
    return o;
}

if (permutation2rank([1,0,2]) == 2) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(rank2permutation([0,1,2],1), [0,2,1])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(permutation2rank([2,0,3,1]),13)) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(rank2permutation([1,3,2,0],7), [1,0,3,2])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
