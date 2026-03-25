#! /usr/bin/node

"use strict"

function validtimes(a) {
    let combinator = [];
    a.split("").forEach((c, i) => {
        if (/\d/.test(c)) {
            combinator.push([1 * c]);
        } else {
            let j = 0;
            if (i == 0) {
                j = 2;
            } else if (i == 1 || i == 4) {
                j = 9;
            } else if (i == 3) {
                j = 5;
            }
            if (j > 0) {
                let p = [];
                for (let x = 0; x <= j; x++) {
                    p.push(x);
                }
                combinator.push(p);
            }
        }
    });
    if (combinator.length != 4) {
        return 0;
    }
    const minutes = combinator[2].length * combinator[3].length;
    let ct = 0;
    for (let ax of combinator[0]) {
        for (let bx of combinator[1]) {
            if (ax * 10 + bx <= 23) {
                ct += 1;
            }
        }
    }
    return ct * minutes;
}

if (validtimes('?2:34') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (validtimes('?4:?0') == 12) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (validtimes('??:??') == 1440) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (validtimes('?3:45') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (validtimes('2?:15') == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
