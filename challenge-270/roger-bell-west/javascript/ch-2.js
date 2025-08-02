#! /usr/bin/node

"use strict"

function equalizearray(a0, x, y) {
    let a = [...a0];
    a.sort();
    const limit = a[a.length - 1];
    let queue = [];
    queue.push([a, 0]);
    let mc = -1;
    while (queue.length > 0) {
        const op = queue.shift();
        if (mc ==-1 || mc > op[1]) {
            if (op[0][0] == op[0][op[0].length - 1]) {
                mc = op[1];
            } else {
                let p = [...op[0]];
                p[0]++;
                if (p[0] <= limit) {
                    p.sort();
                    queue.push([p, op[1] + x]);
                    let q = [...op[0]];
                    q[0]++;
                    q[1]++;
                    if (q[1] <= limit) {
                        q.sort();
                        queue.push([q, op[1] + y]);
                    }
                }
            }
        }
    }
    return mc
}

if (equalizearray([4, 1], 3, 2) == 9) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (equalizearray([2, 3, 3, 3, 5], 2, 1) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
