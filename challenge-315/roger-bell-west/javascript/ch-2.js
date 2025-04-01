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

// by VLAZ
// https://stackoverflow.com/a/59322890
function toWindows(inputArray, size) {
  return Array.from(
    {length: inputArray.length - (size - 1)}, //get the appropriate length
    (_, index) => inputArray.slice(index, index+size) //create the windows
  )
}

function findthird(s, a, b) {
    let ss = [];
    let sa = "";
    for (let c of s.split("")) {
        if (c.search(/[A-Za-z]/i) != -1) {
            sa += c;
        } else {
            if (sa.length > 0) {
                ss.push(sa);
                sa = "";
            }
        }
    }
    if (sa.len > 0) {
        ss.push(sa);
    }
    let out = [];
    for (let p of toWindows(ss, 3)) {
        if (p[0] == a && p[1] == b) {
            out.push(p[2]);
        }
    }
    return out;
}

if (deepEqual(findthird('Perl is a my favourite language but Python is my favourite too.', 'my', 'favourite'), ['language', 'too'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(findthird('Barbie is a beautiful doll also also a beautiful princess.', 'a', 'beautiful'), ['doll', 'princess'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(findthird('we will we will rock you rock you.', 'we', 'will'), ['we', 'rock'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
