#! /usr/bin/node

"use strict"

function longestparenthesis(aa) {
    const a = aa.split('');
    let ml = 0;
    for (let l = 0 ; l < a.length; l++) {
        for (let r = l; r < a.length; r++) {
            let depth = 0;
            let constid = true;
            for (let i = l; i <= r; i++) {
                if (a[i] == '(') {
                    depth += 1;
                } else {
                    depth -= 1;
                    if (depth < 0) {
                        constid = false;
                    }
                }
            }
            if (depth != 0) {
                constid = false;
            }
            if (constid) {
                ml = Math.max(ml, r - l + 1);
            }
        }
    }
    return ml;
}

if (longestparenthesis('(()())') == 6) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (longestparenthesis(')()())') == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (longestparenthesis('((()))()(((()') == 8) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (longestparenthesis('))))((()(') == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (longestparenthesis('()(()') == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
