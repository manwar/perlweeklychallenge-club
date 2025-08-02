#! /usr/bin/node

"use strict"

function permute(a) {
    let out = [];
    let n=a.length;
    let c=[];
    for (let i = 0; i < n; i++) {
        c.push(0);
    }
    out.push([...a]);
    let i=0;
    while (true) {
        if (i >= n) {
            break;
        }
        if (c[i] < i) {
            if (i % 2 == 0) {
                [a[0],a[i]] = [a[i],a[0]];
            } else {
                [a[c[i]],a[i]] = [a[i],a[c[i]]];
            }
            out.push([...a]);
            c[i]++;
            i=0;
        } else {
            c[i]=0;
            i++;
        }
    }
    return out;
}

function dictionaryrank(a) {
    const c = a.split("");
    let d = new Set;
    for (let o of permute(c)) {
        d.add(o.join(""));
    }
    let dd = new Array(...d);
    dd.sort();
    for (let i = 0; i < dd.length; i++) {
        if (dd[i] == a) {
            return i + 1;
        }
    }
    return 0;
}

if (dictionaryrank('CAT') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (dictionaryrank('GOOGLE') == 88) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (dictionaryrank('SECRET') == 255) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
