#! /usr/bin/node

"use strict"

function range(from, to) {
    let a = new Array();
    for (let i = from; i <= to; i++) {
        a.push(i);
    }
    return a;
}

function spellboundsorting(a) {
    let w = a.map(x => towords(x));
    let i = range(0, a.length - 1);
    i.sort(function(a, b) {
        return ('' + w[a]).localeCompare(w[b]);
    });
    return i.map(x => a[x]);
}

function towords(a) {
    if (a == 0) {
        return "zero";
    }
    let components = [];
    let b = a;
    if (a < 0) {
        b = -a;
        components.push("minus");
    }
    const vw = [
        [1000000000, "milliard"],
        [1000000, "million"],
        [1000, "thousand"],
        [100, "hundred"],
        [90, "ninety"],
        [80, "eighty"],
        [70, "seventy"],
        [60, "sixty"],
        [50, "fifty"],
        [40, "forty"],
        [30, "thirty"],
        [20, "twenty"],
        [19, "nineteen"],
        [18, "eighteen"],
        [17, "seventeen"],
        [16, "sixteen"],
        [15, "fifteen"],
        [14, "fourteen"],
        [13, "thirteen"],
        [12, "twelve"],
        [11, "eleven"],
        [10, "ten"],
        [9, "nine"],
        [8, "eight"],
        [7, "seven"],
        [6, "six"],
        [5, "five"],
        [4, "four"],
        [3, "three"],
        [2, "two"],
        [1, "one"]
    ];
    for (let w of cw(b, vw)) {
        components.push(w);
    }
    return components.join(" ");
}

function cw(n, vw) {
    let res = [];
    let vl, word;
    for ([vl, word] of vw) {
        if (n >= vl) {
            let andflag = false;
            if (n >= 100) {
                andflag = true;
                for (let w of cw(Math.floor(n / vl), vw)) {
                    res.push(w);
                }
            }
            res.push(word);
            const p = n % vl;
            if (p > 0) {
                if (andflag) {
                    res.push("and");
                }
                for (let w of cw(p, vw)) {
                    res.push(w);
                }
            }
            break;
        }
    }
    return res;
}

// by Frank Tan
// https://stackoverflow.com/questions/38400594/javascript-deep-comparison
function deepEqual(a,b)
{
    if( (typeof a == 'object' && a != null) &&
        (typeof b == 'object' && b != null) )
    {
        let count = [0,0];
        for( let key in a) count[0]++;
        for( let key in b) count[1]++;
        if( count[0]-count[1] != 0) {return false;}
        for( let key in a)
        {
            if(!(key in b) || !deepEqual(a[key],b[key])) {return false;}
        }
        for( let key in b)
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

if (deepEqual(spellboundsorting([6, 7, 8, 9, 10]), [8, 9, 7, 6, 10])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(spellboundsorting([-3, 0, 1000, 99]), [-3, 99, 1000, 0])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(spellboundsorting([1, 2, 3, 4, 5]), [5, 4, 1, 3, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(spellboundsorting([0, -1, -2, -3, -4]), [-4, -1, -3, -2, 0])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(spellboundsorting([100, 101, 102]), [100, 101, 102])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
