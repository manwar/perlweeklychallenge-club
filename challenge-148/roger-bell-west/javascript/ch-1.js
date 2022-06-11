#! /usr/bin/node

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

function eban(mx) {
    let units=[true,false,true,false,true,false,true,false,false,false];
    let tens=[true,false,false,true,true,true,true,false,false,false,false];
    let out=[];
    for (let i = 0; i <= mx; i++) {
        if (tens[Math.floor(i/10)] &&
            units[i%10] &&
            i != 0) {
            out.push(i);
        }
    }
    return out;
}

if (deepEqual(eban(100),[2, 4, 6, 30, 32, 34, 36, 40, 42, 44, 46, 50, 52, 54, 56, 60, 62, 64, 66])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");

