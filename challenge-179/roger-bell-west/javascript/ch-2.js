#! /usr/bin/node

"use strict"

function sparkline(nn) {
    let bar = [];
    for (let bc = 9601; bc <= 9608; bc++) {
        bar.push(String.fromCharCode(bc));
    }
    let mn = Math.min(...nn);
    let mx = Math.max(...nn);
    let inscale = mx - mn;
    let outscale = bar.length;
    let out = "";
    for (let v of nn) {
        let va = Math.min(Math.floor((v - mn) / inscale * outscale),
                          outscale - 1);
        out += bar[va];
    }
    return out;
}

if (sparkline([0, 100]) == "▁█") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (sparkline([1, 2, 3, 4, 5, 6, 7, 8]) == "▁▂▃▄▅▆▇█") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
