#! /usr/bin/node

"use strict"

function magicexpression(number, target) {
    const n = number.split('');
    const l = number.length - 1;
    let counter = new Array(l).fill(0);
    let out = [];
    const rx = new RegExp("(^|[^0-9])0[0-9]");
    LOOP:
    while (true) {
        let i = 0;
        counter[i]++;
        while (counter[i] == 4) {
            counter[i] = 0;
            i++;
            if (i < l) {
                counter[i]++;
            } else {
                break LOOP;
            }
        }
        let ex = "";
        for (let i = 0; i < l; i++) {
            ex += n[i];
            ex += ["", '+', '-', '*'][counter[i]];
        }
        ex += n[l];
        if (ex.search(rx) != -1) {
            continue LOOP;
        }
        if (eval(ex) == target) {
            out.push(ex);
        }
    }
    out.sort();
    return out;
}

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

if (deepEqual(magicexpression('123', 6), ['1*2*3', '1+2+3'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(magicexpression('105', 5), ['1*0+5', '10-5'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(magicexpression('232', 8), ['2*3+2', '2+3*2'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(magicexpression('1234', 10), ['1*2*3+4', '1+2+3+4'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(magicexpression('1001', 2), ['1+0*0+1', '1+0+0+1', '1+0-0+1', '1-0*0+1', '1-0+0+1', '1-0-0+1'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
