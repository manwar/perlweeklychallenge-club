#! /usr/bin/node

"use strict"

function wordsquares(a) {
    const l = a[0].length;
    const words = new Set(a);
    let queue = [];
    for (let w of a) {
        queue.push([w]);
    }
    while (queue.length > 0) {
        const p = queue.shift();
        if (p.length == l) {
            return p;
        } else {
            let sp = new Set(p);
            for (let ca of new Set([...words].filter(x => !sp.has(x)))) {
                let valid = true;
                let lp = true
                ca.split("").forEach((c, i) => {
                    if (lp) {
                        if (i >= p.length) {
                            lp = false;
                        }
                        if (lp && c != p[i].substring(p.length, p.length + 1)) {
                            valid = false;
                            lp = false;
                        }
                    }
                });
                if (valid) {
                    let pw = [...p];
                    pw.push(ca);
                    queue.push(pw);
                }
            }
        }
    }
    return [];
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

if (deepEqual(wordsquares(['MA', 'AM', 'MY', 'ME']), ['MA', 'AM'])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(wordsquares(['SUN', 'USE', 'NET', 'SEE', 'TEN']), ['SUN', 'USE', 'NET'])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(wordsquares(['BOAT', 'TEAL', 'AREA', 'TSAR', 'OGRE']), ['BOAT', 'OGRE', 'AREA', 'TEAL'])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(wordsquares(['CARD', 'AREA', 'REAR', 'DART']), ['CARD', 'AREA', 'REAR', 'DART'])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(wordsquares(['HEART', 'TREND', 'EMBER', 'RESIN', 'ABUSE']), ['HEART', 'EMBER', 'ABUSE', 'RESIN', 'TREND'])) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
