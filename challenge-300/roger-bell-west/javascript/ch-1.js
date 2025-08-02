#! /usr/bin/node

"use strict"

function range(from, to) {
    let a = new Array(to - from + 1);
    for (let i = from; i <= to; i++) {
        a[i - from] = i;
    }
    return a;
}

function beautifularrangement(a) {
    let precalc = []
    for (let i = 0; i <= a; i++) {
        precalc.push(new Array(a + 1).fill(false));
    }
    for (let i = 1; i <= a; i++) {
        for (let j = i; j <= a; j += i) {
    precalc[i][j] = true;
    precalc[j][i] = true;
        }
    }
    let ct = 0
    let stack = [range(1, a)];
    while (stack.length > 0) {
        const trail = stack.pop();
        if (trail.length == 1) {
            ct += 1;
        } else {
            const p = a - trail.length + 2;
            for (let i of trail) {
                if (precalc[i][p]) {
                    const tt = trail.filter(x => x != i);
                    stack.push(tt);
                }
            }
        }
    }
    return ct;
}

if (beautifularrangement(2) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (beautifularrangement(1) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (beautifularrangement(10) == 700) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (beautifularrangement(20) == 1939684) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
