#! /usr/bin/node

"use strict"

function duplicateremovals(a) {
    var b = [];
    for (let c of a.split("")) {
        if (b.length == 0 || c != b[b.length - 1]) {
            b.push(c);
        } else {
            b.pop();
        }
    }
    return b.join("");
}

if (duplicateremovals('abbaca') == 'ca') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (duplicateremovals('azxxzy') == 'ay') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (duplicateremovals('aaaaaaaa') == '') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (duplicateremovals('aabccba') == 'a') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (duplicateremovals('abcddcba') == '') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
