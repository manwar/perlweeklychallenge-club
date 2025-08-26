#! /usr/bin/node

"use strict"

function counterify(a) {
    let cc = new Map;
    for (let x of a) {
        if (!cc.has(x)) {
            cc.set(x, 0);
        }
        cc.set(x, cc.get(x) + 1);
    }
    return cc;
}

function equalgroup(a) {
    const s = counterify(a);
    let v = [...new Set(s.values())];
    v.sort();
    const l = v[0];
    if (l < 2) {
        return false;
    }
    for (let t = 2; t <= l; t++) {
        let all = true;
        for (let c of v) {
            if (c % t != 0) {
                all = false;
                break;
            }
        }
        if (all) {
            return true;
        }
    }
    return false;
}

if (equalgroup([1, 1, 2, 2, 2, 2])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!equalgroup([1, 1, 1, 2, 2, 2, 3, 3])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (equalgroup([5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!equalgroup([1, 2, 3, 4])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (equalgroup([8, 8, 9, 9, 10, 10, 11, 11])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
