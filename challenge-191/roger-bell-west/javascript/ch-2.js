#! /usr/bin/node

"use strict"

function cutelist(n) {
    let tab = [[false]];
    let t = [];
    for (let x = 1; x <= n; x++) {
        tab.push(new Array(n+1).fill(false));
        t.push(x);
    }
    for (let x = 1; x <= n; x++) {
        for (let y = 1; y <= x; y++) {
            if (x % y != 0 && y % x != 0) {
                tab[x][y] = true;
                tab[y][x] = true;
            }
        }
    }
    let count = 0;
    let stackl = [[]];
    let stackc = [t];
    while (stackl.length != 0) {
        let l = stackl.pop();
        let c = stackc.pop();
        if (c.length == 0 && l.length == n)  {
            count++;
        } else {
            let place = l.length + 1;
            for (let candidate of c) {
                if (!tab[place][candidate]) {
                    let q = Array.from(l);
                    q.push(candidate);
                    stackl.push(q);
                    stackc.push(Array.from(c.filter(i => i != candidate)));
                }
            }
        }
    }
    return count;
}

if (cutelist(2) == 2) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (cutelist(10) == 700) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (cutelist(15) == 24679) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
