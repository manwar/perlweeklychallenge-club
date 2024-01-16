#! /usr/bin/node

"use strict"

function secretsanta(name) {
    let family = [];
    for (let n of name) {
        let surname = n.split(" ");
        family.push(surname[surname.length - 1]);
    }
    let receivers = new Set(Array(name.length).fill().map((element, index) => index));
    let gifting = [];
    for (let giver = 0; giver < name.length; giver++) {
        let done = false;
        let r = 0;
        for (let recipient of receivers) {
            if (family[giver] != family[recipient]) {
                r = recipient;
                done = true;
                break;
            }
        }
        if (!done) {
            for (let recipient of receivers) {
                if (recipient != giver) {
                    r = recipient;
                    break;
                }
            }
        }
        receivers.delete(r)
        gifting.push([name[giver], name[r]]);
    }
    for (let p of gifting) {
        console.log("%s -> %s", p[0], p[1]);
    }
    console.log("");
    return true;
}

if (secretsanta(['Mr. Wall', 'Mrs. Wall', 'Mr. Anwar', 'Mrs. Anwar', 'Mr. Conway', 'Mr. Cross'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (secretsanta(['Mr. Wall', 'Mrs. Wall', 'Mr. Anwar'])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
