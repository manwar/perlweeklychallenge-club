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

function deleteandearn(a) {
    let ct = counterify(a);
    let mx = 0;
    let stack = [];
    stack.push([ct, 0]);
    while (stack.length > 0) {
        const c = stack.pop()
        if (c[0].size == 0) {
            mx = Math.max(mx, c[1]);
        } else {
            for (let d of c[0].keys()) {
                let cc = new Map;
                for (let cx of c[0].keys()) {
                    cc.set(cx, c[0].get(cx));
                }
                cc.set(d, cc.get(d) - 1);
                if (cc.get(d) == 0) {
                    cc.delete(d);
                }
                cc.delete(d + 1);
                cc.delete(d - 1);
                stack.push([cc, c[1] + d]);
            }
        }
    }
    return mx;
}

if (deleteandearn([3, 4, 2]) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (deleteandearn([2, 2, 3, 3, 3, 4]) == 9) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
