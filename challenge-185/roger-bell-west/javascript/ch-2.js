#! /usr/bin/node

"use strict"

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

function recomposemaskcode(list) {
    let out = [];
    for (let ins of list) {
        let count = 0;
        let os = "";
        for (let c of ins) {
            if ((c >= '0' && c <= '9') || (c >= 'a' && c <= 'z')) {
                if (count < 4) {
                    count++;
                    os += "x";
                } else {
                    os += c;
                }
            } else {
                os += c;
            }
        }
        out.push(os);
    }
    return out;
}

if (deepEqual(recomposemaskcode(["ab-cde-123", "123.abc.420",
                                 "3abc-0010.xy"]),
              ["xx-xxe-123", "xxx.xbc.420", "xxxx-0010.xy"])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(recomposemaskcode(["1234567.a", "a-1234-bc",
                                 "a.b.c.d.e.f"]),
              ["xxxx567.a", "x-xxx4-bc", "x.x.x.x.e.f"])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
