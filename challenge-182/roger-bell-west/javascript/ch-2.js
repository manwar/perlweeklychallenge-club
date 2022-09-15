#! /usr/bin/node

"use strict"

function commonpath(p) {
    let pa = [];
    let pl = [];
    for (let sp of p) {
        let q = sp.split("/");
        pl.push(q.length);
        pa.push(q);
    }
    let out = [];
    for (let cl = 0; cl < Math.min(...pl); cl++) {
        let ex = false;
        let tx = pa[0][cl];
        for (let pe of pa) {
            if (pe[cl] != tx) {
                ex = true;
                break;
            }
        }
        if (ex) {
            break;
        }
        out.push(tx);
    }
    return out.join("/");
}

if (commonpath([
    "/a/b/c/1/x.pl",
    "/a/b/c/d/e/2/x.pl",
    "/a/b/c/d/3/x.pl",
    "/a/b/c/4/x.pl",
    "/a/b/c/d/5/x.pl"
]) == "/a/b/c") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
