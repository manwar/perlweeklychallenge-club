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

function lastsunday(year0) {
    let year = year0;
    let o = [];
    for (let month0 = 2; month0 <= 13; month0++) {
        let month = month0;
        if (month0 == 13) {
            year++;
            month -= 12;
        }
        let dt = new Date(year,month-1,1,12,0,0);
        dt.setDate(dt.getDate() - 1);
        let dl = dt.getDay();
        if (dl != 0) {
          dt.setDate(dt.getDate() - dl);
        }
        o.push(dt.toISOString().substring(0,10));
    }
    return o;
}

if (deepEqual(lastsunday(2022),[ '2022-01-30',
                                 '2022-02-27',
                                 '2022-03-27',
                                 '2022-04-24',
                                 '2022-05-29',
                                 '2022-06-26',
                                 '2022-07-31',
                                 '2022-08-28',
                                 '2022-09-25',
                                 '2022-10-30',
                                 '2022-11-27',
                                 '2022-12-25'
                               ])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
