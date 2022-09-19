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

function datedifference(d1s, d2s) {
    let d1 = new Date(Date.parse(d1s + " 00:00:00 GMT"));
    let d2 = new Date(Date.parse(d2s + " 00:00:00 GMT"));
    if (d1 > d2) {
        let t = d1;
        let d1 = d2;
        let d2 = t;
    }
    let yd = d2.getYear() - d1.getYear();
    let inter = new Date(Date.UTC(d2.getYear()+1900, d1.getMonth(), d1.getDate()));
    if (d1.getMonth() > d2.getMonth() ||
        (d1.getMonth() == d2.getMonth() && d1.getDate() > d2.getDate())) {
        inter = new Date(Date.UTC(d2.getYear()+1900-1, d1.getMonth(), d1.getDate()));
        yd--;
    }
    return [yd, (d2 - inter) / 86400000];
}

if (deepEqual(datedifference('2019-02-10', '2022-11-01'),
              [3, 264])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (deepEqual(datedifference('2020-09-15', '2022-03-29'),
              [1, 195])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
