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

function reducedrowechelon(a) {
    let leadingone = [];
    let valid = true;
    for (let row of a) {
        let lp = -1;
        row.forEach((cell, cn) => {
            if (lp == -1) {
                if (cell == 1) {
                    lp = cn;
                } else if (cell != 0) {
                    valid = false;
                }
            }
        });
        leadingone.push(lp);
    }
    if (!valid) {
        return false;
    }
    while (leadingone[leadingone.length-1] == -1) {
        leadingone.pop();
    }
    let c = [...leadingone];
    c.sort(function(a,b) {
        return a-b;
    });
    if (c[0] == -1) {
        return false;
    }
    if (!deepEqual(c, leadingone)) {
        return false;
    }
    for (let i of c) {
        let col = a.map(r => r[i]);
        col.sort(function(a,b) {
            return a-b;
        });
        if (col[col.length-1] != 1 ||
            col[col.length-2] != 0 ||
            col[0] != 0) {
            return false;
        }
    }
    return true;
}

if (!reducedrowechelon([[1, 1, 0], [0, 1, 0], [0, 0, 0]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reducedrowechelon([[0, 1, -2, 0, 1], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (reducedrowechelon([[1, 0, 0, 4], [0, 1, 0, 7], [0, 0, 1, -1]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!reducedrowechelon([[0, 1, -2, 0, 1], [0, 0, 0, 0, 0], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!reducedrowechelon([[0, 1, 0], [0, 1, 0], [0, 0, 0]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!reducedrowechelon([[4, 0, 0, 0], [0, 1, 0, 7], [0, 0, 1, -1]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!reducedrowechelon([[1, 0, 0, 4], [1, 0, 0, 7], [0, 0, 1, -1]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!reducedrowechelon([[1, -2, 0, 4], [0, 1, 0, 7], [0, 0, 1, -1]])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
