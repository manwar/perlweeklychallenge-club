#! /usr/bin/node

"use strict"

function brokenkeys(name, typed) {
    const nt = name.split("");
    const tt = typed.split("");
    let ni = 0;
    let ti = 0;
    while (true) {
        if (nt[ni] != tt[ti]) {
            return false;
        }
        if (ti == tt.length - 1) {
            break;
        } else {
            if (ni < nt.length - 1 && nt[ni + 1] == nt[ni]) {
                ni += 1;
            } else {
                while (ti < tt.length && tt[ti] == nt[ni]) {
                    ti += 1;
                }
                if (ti == tt.length) {
                    break;
                }
                ni += 1;
            }
        }
    }
    return true;
}

if (brokenkeys('perl', 'perrrl')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (brokenkeys('raku', 'rrakuuuu')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!brokenkeys('python', 'perl')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (brokenkeys('coffeescript', 'cofffeescccript')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
