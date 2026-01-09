#! /usr/bin/node

"use strict"

function minabsdiff(a) {
    let b = a;
    b.sort(function(a,b) {
        return a-b;
    });
    let out = [];
    let mindiff = 1 + b[b.length - 1] - b[0];
    for (let c of toWindows(b, 2)) {
        const d = c[1] - c[0];
        if (d < mindiff) {
            out = [];
            mindiff = d;
        }
        if (d == mindiff) {
            out.push(c);
        }
    }
    return out;
}

// by VLAZ
// https://stackoverflow.com/a/59322890
function toWindows(inputArray, size) {
  return Array.from(
    {length: inputArray.length - (size - 1)}, //get the appropriate length
    (_, index) => inputArray.slice(index, index+size) //create the windows
  )
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

if (deepEqual(minabsdiff([4, 2, 1, 3]), [[1, 2], [2, 3], [3, 4]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(minabsdiff([10, 100, 20, 30]), [[10, 20], [20, 30]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(minabsdiff([-5, -2, 0, 3]), [[-2, 0]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(minabsdiff([8, 1, 15, 3]), [[1, 3]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(minabsdiff([12, 5, 9, 1, 15]), [[9, 12], [12, 15]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
