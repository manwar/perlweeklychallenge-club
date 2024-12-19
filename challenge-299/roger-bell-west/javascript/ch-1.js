#! /usr/bin/node

"use strict"

function replacewords(ww, a) {
    let out = [];
    for (let w of a.split(" ")) {
        let r = false;
        for (let lw of ww) {
            if (w.startsWith(lw)) {
                out.push(lw);
                r = true;
                break;
            }
        }
        if (!r) {
            out.push(w);
        }
    }
    return out.join(" ");
}

if (replacewords(['cat', 'bat', 'rat'], 'the cattle was rattle by the battery') == 'the cat was rat by the bat') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (replacewords(['a', 'b', 'c'], 'aab aac and cac bab') == 'a a a c b') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (replacewords(['man', 'bike'], 'the manager was hit by a biker') == 'the man was hit by a bike') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
