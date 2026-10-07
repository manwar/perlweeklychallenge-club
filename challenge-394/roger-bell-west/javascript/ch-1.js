#! /usr/bin/node

"use strict"

function alternatecase(a) {
    const uppers = a.split("").map(c => c === c.toUpperCase());
    let queue = [];
    queue.push([uppers, 0]);
    while (queue.length > 0) {
        const upct = queue.shift();
        const up = upct[0];
        const ct = upct[1];
        let swaps = [];
        for (let i = 0; i <= up.length - 2; i++) {
            if (up[i] == up[i + 1]) {
                if (i > 0) {
                    swaps.push(i - 1);
                }
                if (i < up.length - 2) {
                    swaps.push(i + 1);
                }
            }
        }
        if (swaps.length == 0) {
            return ct;
        } else {
            for (let sw of swaps) {
                let uq = [...up];
                const tmp = uq[sw];
                uq[sw] = uq[sw + 1];
                uq[sw + 1] = tmp;
                queue.push([uq, ct + 1]);
            }
        }
    }
    return 0;
}

if (alternatecase('aAbB') == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (alternatecase('AAbb') == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (alternatecase('AAAbbb') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (alternatecase('aABb') == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (alternatecase('bBBAaa') == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
