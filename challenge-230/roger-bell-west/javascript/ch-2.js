#! /usr/bin/node

"use strict"

function prefixwords(s, p) {
    return s.filter(x => x.startsWith(p)).length;
}

if (prefixwords(['pay', 'attention', 'practice', 'attend'], 'at') == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (prefixwords(['janet', 'julia', 'java', 'javascript'], 'ja') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
