#! /usr/bin/node

"use strict"

function sevensegment(l) {
    let disp = [0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f, 0x67];
    let v = [];
    if (l == 0) {
        v.push(0);
    } else {
        let ll = l;
        while (ll > 0) {
            v.push(ll % 10);
            ll = parseInt(ll / 10);
        }
        v = v.reverse();
    }
    let d = [];
    for (let r = 1; r <= 7; r++) {
        d.push(new Array(6*v.length).fill(" "));
    }
    v.forEach((vv, i) => {
        let x = 6 * i;
        let da = disp[vv];
        if ((da & 1) > 0) {
            for (let xa = x + 1; xa <= x + 3; xa++) {
                d[0][xa] = '#';
            }
        }
        if ((da & 2) > 0) {
            for (let y = 1; y <= 2; y++) {
                d[y][x+4] = '#';
            }
        }
        if ((da & 4) > 0) {
            for (let y = 4; y <= 5; y++) {
                d[y][x+4] = '#';
            }
        }
        if ((da & 8) > 0) {
            for (let xa = x + 1; xa <= x + 3; xa++) {
                d[6][xa] = '#';
            }
        }
        if ((da & 16) > 0) {
            for (let y = 4; y <= 5; y++) {
                d[y][x] = '#';
            }
        }
        if ((da & 32) > 0) {
            for (let y = 1; y <= 2; y++) {
                d[y][x] = '#';
            }
        }
        if ((da & 64) > 0) {
            for (let xa = x + 1; xa <= x + 3; xa++) {
                d[3][xa] = '#';
            }
        }
    });
    for (let r of d) {
        process.stdout.write(r.join(""));
        process.stdout.write("\n");
    }
}

sevensegment(1234567890);
sevensegment(200);
