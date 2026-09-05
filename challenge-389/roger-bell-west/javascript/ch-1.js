#! /usr/bin/node

"use strict"

function reordernotes(composer, notes, order) {
    let out = new Array(order.length).fill("");
    order.forEach((n, i) => {
        out[n - 1] = notes[i];
    });
    return new Map([[composer, out]]);
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

if (deepEqual(reordernotes('Mozart', ['C', 'D', 'E', 'F', 'G', 'A', 'B'], [7, 1, 6, 2, 5, 3, 4]), new Map([['Mozart', ['D', 'F', 'A', 'B', 'G', 'E', 'C']]]))) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(reordernotes('Chopin', ['C', 'C#', 'D', 'D#', 'E', 'F'], [6, 5, 4, 3, 2, 1]), new Map([['Chopin', ['F', 'E', 'D#', 'D', 'C#', 'C']]]))) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(reordernotes('Vivaldi', ['A', 'B', 'C', 'D', 'E'], [1, 2, 3, 4, 5]), new Map([['Vivaldi', ['A', 'B', 'C', 'D', 'E']]]))) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(reordernotes('Debussy', ['C', 'D', 'F', 'G', 'A'], [1, 3, 5, 2, 4]), new Map([['Debussy', ['C', 'G', 'D', 'A', 'F']]]))) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(reordernotes('Stravinsky', ['C#'], [1]), new Map([['Stravinsky', ['C#']]]))) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
