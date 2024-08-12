#! /usr/bin/node

"use strict"

function cs2xy(a) {
    const x = a.charCodeAt(0) - 'a'.charCodeAt(0);
    const y = a.charCodeAt(1) - '1'.charCodeAt(0);
    return [x, y];
}

function knightsmove(from, to) {
    const fc = cs2xy(from);
    const tc = cs2xy(to);
    let queue = [];
    queue.push([fc[0], fc[1], 0]);
    let seen = new Set;
    while (queue.length > 0) {
        const cc = queue.shift();
        if (cc[0] == tc[0] && cc[1] == tc[1]) {
            return cc[2];
        } else {
            for (let offset of [
                [2, 1],
                [1, 2],
                [2, -1],
                [1, -2],
                [-2, 1],
                [-1, 2],
                [-2, -1],
                [-1, -2]
            ]) {
                const x = cc[0] + offset[0];
                const y = cc[1] + offset[1];
                if (x >= 0 && x <= 7 && y >= 0 && y <= 7) {
                    const cv = x * 8 + y;
                    if (!seen.has(cv)) {
                        queue.push([x, y, cc[2] + 1]);
                        seen.add(cv);
                    }
                }
            }
        }
    }
    return -1;
}

if (knightsmove('g2', 'a8') == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (knightsmove('g2', 'h2') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
