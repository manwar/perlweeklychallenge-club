#! /usr/bin/node

"use strict"

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

function arraydegree(a) {
    let f = new Map();
    for (let x of a) {
        if (f.has(x)) {
            f.set(x, f.get(x)+1);
        } else {
            f.set(x, 1);
        }
    }
    let degree = Math.max(...f.values());
    let inverse = new Map();
    for (let i = 0; i < a.length; i++) {
        let x = a[i];
        if (inverse.has(x)) {
            inverse.set(x,[inverse.get(x)[0], i]);
        } else {
            inverse.set(x,[i, i]);
        }
    }
    let minlen = 1 + a.length;
    let se = [0, 0];
    for (let n of f.keys()) {
        if (f.get(n) == degree) {
            let ll = 1 + inverse.get(n)[1] - inverse.get(n)[0];
            if (ll < minlen) {
                minlen = ll;
                se = inverse.get(n);
            }
        }
    }
    return a.slice(se[0], se[1]+1);
}

if (deepEqual(arraydegree([1, 3, 3, 2]), [3, 3])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(arraydegree([1, 2, 1, 3]), [1, 2, 1])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(arraydegree([1, 3, 2, 1, 2]), [2, 1, 2])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(arraydegree([1, 1, 2, 3, 2]), [1, 1])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(arraydegree([2, 1, 2, 1, 1]), [1, 2, 1, 1])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
