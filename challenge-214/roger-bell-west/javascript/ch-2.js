#! /usr/bin/node

"use strict"

function collectpoints(a) {
    let m = [];
    let st = 0;
    while (st < a.length) {
        const k = a[st];
        let e = st;
        while (e < a.length && a[e] == k) {
            e += 1;
        }
        m.push([k, e - st]);
        st = e;
    }
    let rv = 0;
    let stack = [[m, 0]];
    while (stack.length > 0) {
        const s = stack.pop();
        if (s[0].length == 0) {
            rv = Math.max(rv, s[1]);
        } else {
            for (let i = 0; i < s[0].length; i++) {
                let ss = JSON.parse(JSON.stringify(s));
                ss[1] += ss[0][i][1] * ss[0][i][1];
                ss[0].splice(i, 1);
                let j = i;
                while (true) {
                    if (j > 0 &&
                        j < ss[0].length &&
                        ss[0][j][0] == ss[0][j - 1][0]) {
                        ss[0][j][1] += ss[0][j - 1][1];
                        ss[0].splice(j - 1, 1);
                        j -= 1;
                    } else {
                        break;
                    }
                }
                stack.push(ss);
            }
        }
    }
    return rv;
}

if (collectpoints([2, 4, 3, 3, 3, 4, 5, 4, 2]) == 23) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (collectpoints([1, 2, 2, 2, 2, 1]) == 20) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (collectpoints([1]) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (collectpoints([2, 2, 2, 1, 1, 2, 2, 2]) == 40) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
