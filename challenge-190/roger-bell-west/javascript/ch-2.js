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

function decodedlist(s) {
    let stack = [[s]];
    let out = new Set();
    while (true) {
        let ent = stack.shift();
        let tail = ent.pop();
        if (tail.length == 0) {
            out.add(JSON.stringify(ent));
        } else {
            if (tail.slice(0,1) != "0") {
                let q = [...ent];
                q.push(tail.slice(0,1));
                q.push(tail.slice(1));
                stack.push(q);
            }
            if (tail.length >= 2) {
                let v = parseInt(tail.slice(0,2));
                if (v >= 1 && v <= 26) {
                    let q = [...ent];
                    q.push(tail.slice(0,2));
                    q.push(tail.slice(2));
                    stack.push(q);
                }
            }
        }
        if (stack.length == 0) {
            break;
        }
    }
    let k = []
    let alphazero = "A".charCodeAt(0) - 1;
    for (let x of out) {
        k.push(JSON.parse(x).map(i => String.fromCharCode(alphazero + parseInt(i))).join(""));
    }
    k.sort();
    return k;
}

if (deepEqual(decodedlist("11"), ["AA", "K"])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(decodedlist("1115"), ["AAAE", "AAO", "AKE", "KAE", "KO"])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(decodedlist("127"), ["ABG", "LG"])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
