#! /usr/bin/node

"use strict"

function makeitbigger(st, ch) {
    let i = 0;
    let nv = [];
    let c = st.indexOf(ch, i);
    while (c > -1) {
        let o = "";
        if (c > 0) {
            o += st.slice(0, c);
        }
        if (c < st.length) {
            o += st.slice(c + 1, st.length);
        }
        nv.push(parseInt(o));
        i = c + 1;
        c = st.indexOf(ch, i);
    }
    return Math.max(...nv);
}

if (makeitbigger('15456', '5') == '1546') {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (makeitbigger('7332', '3') == '732') {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (makeitbigger('2231', '2') == '231') {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (makeitbigger('543251', '5') == '54321') {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (makeitbigger('1921', '1') == '921') {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}

process.stdout.write("\n");
