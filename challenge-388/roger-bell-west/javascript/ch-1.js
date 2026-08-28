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

function dyckwords(order) {
    let out = [];
    let queue = [""];
    while (queue.length > 0) {
        const st = queue.shift();
        const dcount = st.split("").filter(c => c == "D").length;
        if (st.length == order * 2) {
            if (dcount == order) {
                out.push(st);
            }
        } else {
            if (dcount * 2 < st.length) {
                queue.push(st + "D");
            }
            queue.push(st + "U");
        }
    }
    return out;
}

if (deepEqual(dyckwords(1), ['UD'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(dyckwords(2), ['UDUD', 'UUDD'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(dyckwords(3), ['UDUDUD', 'UDUUDD', 'UUDDUD', 'UUDUDD', 'UUUDDD'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(dyckwords(0), [''])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(dyckwords(4), ['UDUDUDUD', 'UDUDUUDD', 'UDUUDDUD', 'UDUUDUDD', 'UDUUUDDD', 'UUDDUDUD', 'UUDDUUDD', 'UUDUDDUD', 'UUDUDUDD', 'UUDUUDDD', 'UUUDDDUD', 'UUUDDUDD', 'UUUDUDDD', 'UUUUDDDD'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
