#! /usr/bin/node

"use strict"

function common_substring(a0) {
    let a = [...a0];
    a.sort(function(a, b) {
        return a.length - b.length;
    });
    let results = [];
    for (let l = a[0].length - 1; l >= 1; l--) {
        for (let offset = 0; offset <= a[0].length - l; offset++) {
            let m = true;
            const sample = a[0].substring(offset, l + offset);
            for (let axi = 1; axi <= a.length - 1; axi++) {
                if (a[axi].indexOf(sample) == -1) {
                    m = false;
                    break;
                }
            }
            if (m) {
                results.push(sample);
            }
        }
        // if we wanted longest common substring we'd exit here
        // on non-empty results
    }
    return results;
}

function is_avc(a) {
    let constid = true
    let laststate = false
    a.split("").forEach((c, i) => {
        let thisstate = false;
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
            thisstate = true;
        }
        if (i > 0 && thisstate == laststate) {
            constid = false;
        }
        laststate = thisstate;
    });
    return constid;
}
  
function alternatingvowelsconsonants(a) {
    const c2 = common_substring(a).filter(w => is_avc(w));
    if (c2.length > 0) {
        const l = c2[0].length;
        return c2.filter(w => w.length == l);
    } else {
        return [];
    }
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

if (deepEqual(alternatingvowelsconsonants(['relocate', 'delocate', 'allocate']), ['locate'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(alternatingvowelsconsonants(['apple', 'banana', 'cherry']), [])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(alternatingvowelsconsonants(['navigate', 'cavity', 'gravity']), ['avi'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(alternatingvowelsconsonants(['pedalgia', 'pedalboard', 'pedantic']), ['peda'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deepEqual(alternatingvowelsconsonants(['schoolmaster', 'schoolhouse', 'schooling']), ['ho', 'ol'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
