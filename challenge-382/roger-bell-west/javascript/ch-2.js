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

function replacequestionmark(a) {
    const template = a.split('');
    const q = template.filter(x => x == '?').length;
    if (q == 0) {
        return [a];
    }
    let out = []
    const lim = 1 << q;
    for (let n = 0; n < lim; n++) {
        let qm = [];
        let nn = n;
        while (nn > 0) {
            if (nn % 2 == 0) {
                qm.push('0');
            } else {
                qm.push('1');
            }
            nn = Math.floor(nn / 2);
        }
        while (qm.length < q) {
            qm.push('0');
        }
        let entry = "";
        for (let tc of template) {
            if (tc == '?') {
                entry += qm.pop();
            } else {
                entry += tc;
            }
        }
        out.push(entry);
    }
    return out;
}

if (deepEqual(replacequestionmark('01??0'), ['01000', '01010', '01100', '01110'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(replacequestionmark('101'), ['101'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(replacequestionmark('???'), ['000', '001', '010', '011', '100', '101', '110', '111'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(replacequestionmark('1?10'), ['1010', '1110'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(replacequestionmark('1?1?0'), ['10100', '10110', '11100', '11110'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
