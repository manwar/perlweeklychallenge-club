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


function sylvester(ct) {
    let o = [ 2n ];
    for (let i = 2; i <= ct; i++) {
        let x = o[o.length - 1];
        o.push(1n + (x * (x - 1n)));
    }
    return o
}

if (deepEqual(sylvester(10),[
    2n,
    3n,
    7n,
    43n,
    1807n,
    3263443n,
    10650056950807n,
    113423713055421844361000443n,
    12864938683278671740537145998360961546653259485195807n,
    165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443n
])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
