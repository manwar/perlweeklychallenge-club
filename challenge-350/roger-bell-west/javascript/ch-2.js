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

function countdigits(a) {
    return counterify(a.toString());
}

function comparehash(a, b) {
    if (a.size != b.size) {
        return false;
    }
    let h = new Set;
    for (let k of a.keys()) {
        h.add(k);
    }
    for (let k of b.keys()) {
        h.add(k);
    }
    for (let k of h) {
        if (!a.has(k)) {
            return false;
        }
        if (!b.has(k)) {
            return false;
        }
        if (a.get(k) != b.get(k)) {
            return false;
        }
    }
    return true;
}

function shufflepairs(low, high, pairs) {
    let total = 0;
    for (let candidate = low; candidate <= high; candidate++) {
        const candidatec = countdigits(candidate);
        let cnt = 0;
        for (let mul = 2; mul < 10; mul++) {
            const test = candidate * mul;
            const testc = countdigits(test);
            if (comparehash(testc, candidatec)) {
                cnt++;
                if (cnt >= pairs) {
                    break;
                }
            }
        }
        if (cnt >= pairs) {
            total++;
        }
    }
    return total;
}

if (shufflepairs(1, 1000, 1) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (shufflepairs(1500, 2500, 1) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (shufflepairs(1000000, 1500000, 5) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (shufflepairs(13427000, 14100000, 2) == 11) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (shufflepairs(1000, 5000, 1) == 7) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
