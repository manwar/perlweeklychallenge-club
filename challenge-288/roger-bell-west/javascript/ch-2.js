#! /usr/bin/node

"use strict"

function encode(x, y) {
  return x * 1e6 + y;
}

function decode(c) {
  return [Math.floor(c / 1e6), c % 1e6];
}

function contiguousblock(a) {
    const y = a.length;
    const x = a[0].length;
    let starts = new Set;
    for (let cx = 0; cx < x; cx++) {
        for (let cy = 0; cy < y; cy++) {
            starts.add(encode(cx, cy));
        }
    }
    let maxblock = 0;
    while (starts.size > 0) {
        const start = [...starts.keys()][0];
        const cstart = decode(start);
        let queue = [];
        let visited = new Set;
        visited.add(start);
        queue.push(start);
        while (queue.length > 0) {
            const here = queue.shift();
            const chere = decode(here);
            for (let delta of [[-1, 0], [1, 0], [0, -1], [0, 1]]) {
                if ((delta[0] >= 0 || chere[0] > 0)
                    && (delta[0] <= 0 || chere[0] < x - 1)
                    && (delta[1] >= 0 || chere[1] > 0)
                    && (delta[1] <= 0 || chere[1] < y - 1)) {
                    const cthere = [chere[0] + delta[0], chere[1] + delta[1]];
                    const there = encode(...cthere);
                    if (!visited.has(there) &&
                        a[cthere[1]][cthere[0]] ==
                        a[cstart[1]][cstart[0]]) {
                        visited.add(there);
                        queue.push(there);
                    }
                }
            }
        }
        const sz = visited.size;
        if (sz > maxblock) {
            maxblock = sz;
        }
        starts = new Set([...starts].filter(i => !visited.has(i)));
    }
    return maxblock;
}

if (contiguousblock([['x', 'x', 'x', 'x', 'o'], ['x', 'o', 'o', 'o', 'o'], ['x', 'o', 'o', 'o', 'o'], ['x', 'x', 'x', 'o', 'o']]) == 11) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (contiguousblock([['x', 'x', 'x', 'x', 'x'], ['x', 'o', 'o', 'o', 'o'], ['x', 'x', 'x', 'x', 'o'], ['x', 'o', 'o', 'o', 'o']]) == 11) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (contiguousblock([['x', 'x', 'x', 'o', 'o'], ['o', 'o', 'o', 'x', 'x'], ['o', 'x', 'x', 'o', 'o'], ['o', 'o', 'o', 'x', 'x']]) == 7) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
