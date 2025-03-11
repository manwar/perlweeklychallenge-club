#! /usr/bin/node

"use strict"

function ballsandboxes(a) {
    let boxes = new Map;
    let colour = '@';
    a.split("").forEach((c, i) => {
        if (i % 2 == 0) {
            colour = c;
        } else {
            const boxid = parseInt(c);
            let s = new Set;
            if (boxes.has(boxid)) {
                s = boxes.get(boxid);
            }
            s.add(colour);
            boxes.set(boxid, s);
        }
    });
    return [...boxes.values()].filter(x => x.size >= 3).length;
}

if (ballsandboxes('G0B1R2R0B0') == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (ballsandboxes('G1R3R6B3G6B1B6R1G3') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (ballsandboxes('B3B2G1B3') == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
