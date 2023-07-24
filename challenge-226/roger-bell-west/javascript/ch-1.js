#! /usr/bin/node

"use strict"

function shufflestring(st, mp) {
    let r = new Array(st.length).fill(" ");
    for (let i = 0; i < mp.length; i++) {
        r[mp[i]] = st[i];
    }
    return r.join('');
}

if (shufflestring('lacelengh', [3, 2, 0, 5, 4, 8, 6, 7, 1]) == 'challenge') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (shufflestring('rulepark', [4, 7, 3, 1, 0, 5, 2, 6]) == 'perlraku') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
