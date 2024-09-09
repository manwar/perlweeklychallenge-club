#! /usr/bin/node

"use strict"

// by rsp at https://stackoverflow.com/questions/12303989/cartesian-product-of-multiple-arrays-in-javascript
const cartesian =
  (...a) => a.reduce((a, b) => a.flatMap(d => b.map(e => [d, e].flat())));

function makingchange(a) {
    const coins = [1, 5, 10, 25, 50];
    const max = coins.map(x => Math.floor(a / x));
    let pat = [];
    for (let i = 0; i < coins.length; i++) {
        if (max[i] > 0) {
            pat.push(Array(max[i] + 1).fill().map((element, index) => index));
        } else {
            break;
        }
    }
    let ct = 0;
    for (let combo of cartesian(...pat)) {
        let t = 0;
        combo.forEach((c, i) => {
            t += c * coins[i];
        });
        if (t == a) {
            ct++;
        }
    }
    return ct;
}

if (makingchange(9) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (makingchange(15) == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (makingchange(100) == 292) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
