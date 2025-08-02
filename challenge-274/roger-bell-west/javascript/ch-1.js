#! /usr/bin/node

"use strict"

function goatlatin(a) {
    let out = [];
    a.split(" ").forEach((word, ix) => {
        let c = word.split("");
        if (!c[0].match(/[aeiou]/i)) {
            let co = c.shift();
            c.push(co);
        }
        let nw = c.join("");
        nw += "ma";
        for (let i = 0; i <= ix; i++) {
            nw += "a";
        }
        out.push(nw)
    });
    return out.join(" ");
}

if (goatlatin('I love Perl') == 'Imaa ovelmaaa erlPmaaaa') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (goatlatin('Perl and Raku are friends') == 'erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (goatlatin('The Weekly Challenge') == 'heTmaa eeklyWmaaa hallengeCmaaaa') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
