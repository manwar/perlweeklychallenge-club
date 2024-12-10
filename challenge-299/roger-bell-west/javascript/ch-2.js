#! /usr/bin/node

"use strict"

function encode(x, y) {
    return x * 64 + y;
}

function decode(z) {
    return [ Math.floor(z / 64), z % 64 ];
}

function wordsearch(grid0, word0) {
    let grid = new Map;
    grid0.forEach((row, y) => {
        row.forEach((c, x) => {
            grid.set(encode(x, y), c);
        });
    });
    const word = word0.split("");
    for (let [start, firstletter] of grid) {
        if (firstletter == word[0]) {
            let queue = [];
            queue.push([start]);
            while (queue.length > 0) {
                const pos = queue.shift();
                if (pos.length == word.length) {
                    return true;
                } else {
                    for (let dir of [[0, 1], [1, 0], [0, -1], [-1, 0]]) {
                        const lpos = decode(pos[pos.length - 1]);
                        const npos = [lpos[0] + dir[0], lpos[1] + dir[1]];
                        const np = encode(npos[0], npos[1]);
                        if (grid.has(np) &&
                            !pos.includes(np) &&
                            grid.get(np) == word[pos.length]) {
                            let pp = [...pos];
                            pp.push(np);
                            queue.push(pp);
                        }
                    }
                }
            }
        }
    };
    return false;
}

if (wordsearch([['A', 'B', 'D', 'E'], ['C', 'B', 'C', 'A'], ['B', 'A', 'A', 'D'], ['D', 'B', 'B', 'C']], 'BDCA')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!wordsearch([['A', 'A', 'B', 'B'], ['C', 'C', 'B', 'A'], ['C', 'A', 'A', 'A'], ['B', 'B', 'B', 'B']], 'ABAC')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (wordsearch([['B', 'A', 'B', 'A'], ['C', 'C', 'C', 'C'], ['A', 'B', 'A', 'B'], ['B', 'B', 'A', 'A']], 'CCCAA')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
