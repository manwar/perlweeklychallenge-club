#! /usr/bin/node

"use strict"

function r2qi(n) {
    return c2qi(n, 0);
}

function mod(n, m) {
  return ((n % m) + m) % m;
}

function c2qi(r0, i0) {
    let l = [];
    for (let n0 of [i0, r0]) {
        let n = n0;
        let digits = [];
        while (n != 0) {
            let digit = mod(n,-4);
            n = Math.floor(n / -4);
            if (digit < 0) {
                digit += 4;
                n += 1;
            }
            digits.push(digit);
        }
        l.push(digits);
    }
    let ld = l[0].length - l[1].length;
    if (ld < 0) {
        l[0].unshift(...new Array(-ld-1).fill(0));
    } else if (ld > 1) {
        l[1].unshift(...new Array(ld).fill(0)); 
    }
    let o = "";
    for (let i = l[1].length-1; i >= 0; i--) {
        for (let b of [0,1]) {
            if (l[b].length > i) {
                o += l[b][i];
            }
        }
    }
    return o;
}

function qi2r(n) {
    return qi2c(n)[0];
}

function qi2c(n) {
    let pow = 1;
    let ri = 0;
    let o = [0, 0];
    for (let ch of n.split("").reverse()) {
        o[ri] += parseInt(ch) * pow;
        ri++;
        pow *= 2;
        if (ri == 2) {
            ri = 0;
            pow = -pow;
        }
    }
    return o;
}

if (r2qi(4) == "10300") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (qi2r("10300") == 4) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
