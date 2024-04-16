#! /usr/bin/node

"use strict"

function str2hash(a) {
    let m = new Map;
    for (let c of a.split("")) {
        const lc = c.toLowerCase();
        if (lc.search(/[a-z]/) > -1) {
            if (m.has(lc)) {
                m.set(lc, m.get(lc) + 1);
            } else {
                m.set(lc, 1);
            }
        }
    }
    return m;
}

function completingword(a, cw) {
    const ah = str2hash(a);
    let out = [];
    for (let t of cw) {
        let valid = true;
        const th = str2hash(t);
        for (let [k, v] of ah) {
            if (!th.has(k)) {
                valid = false;
                break;
            }
            if (th.get(k) < v) {
                valid = false;
                break;
            }
        }
        if (valid) {
            out.push(t);
        }
    }
    if (out.length == 0) {
        return "";
    }
    out.sort(function(a, b) {
        return a.length - b.length;
    });
    return out[0];
}

if (completingword('aBc 11c', ['accbbb', 'abc', 'abbc']) == 'accbbb') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (completingword('La1 abc', ['abcl', 'baacl', 'abaalc']) == 'baacl') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (completingword('JB 007', ['jj', 'bb', 'bjb']) == 'bjb') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
