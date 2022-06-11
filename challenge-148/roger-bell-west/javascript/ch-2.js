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

function cardano(ct) {
    let out=[];
    let k=0;
    let cn=0;
    while (true) {
        let a=3*k+2;
        let b2c=(k+1)*(k+1)*(8*k+5);
        let b=0;
        let b2=0;
        let inc=1;
        while (true) {
            b++;
            b2 += inc;
            inc += 2;
            if (b2 > b2c) {
                break;
            }
            if (b2c % b2 == 0) {
                out.push([a,b,b2c/b2]);
                cn++;
                if (cn >= ct) {
                    break;
                }
            }
        }
        if (cn >= ct) {
            break;
        }
        k++;
    }
    return out;
}

if (deepEqual(cardano(5),[[2,1,5],[5,1,52],[5,2,13],[8,1,189],[8,3,21]])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");

