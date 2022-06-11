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

function leftfactorial (mx) {
    let out=[];
    let fact=1;
    let sum=0;
    for (let i=0; i < mx; i++) {
        if (i>0) {
            fact *= i;
        }
        sum += fact;
        out.push(sum);
    }
    return out;
}

if (deepEqual(leftfactorial(10),[1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
