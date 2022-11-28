#! /usr/bin/node

"use strict"

function oddstring(ss) {
    let t = ss[0].length - 1;
    for (let i = 0; i < t; i++) {
        let tab = new Map();
        for (let s of ss) {
            let v = s.charCodeAt(i+1) - s.charCodeAt(i);
            let ll = [];
            if (tab.has(v)) {
                ll = tab.get(v);
            }
            ll.push(s);
            tab.set(v,ll);
        }
        for (let j of tab.values()) {
            if (j.length == 1) {
                return j[0];
            }
        }
    }
    return "";
}

if (oddstring(["adc", "wzy", "abc"]) == "abc") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (oddstring(["aaa", "bob", "ccc", "ddd"]) == "bob") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
