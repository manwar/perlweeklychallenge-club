#! /usr/bin/node

"use strict"

function matchsticksquare(a) {
    const perimeter = a.reduce((x, y) => x + y);
    let sidesleft = 4;
    if (perimeter % 4 != 0) {
        return false;
    }
    let side = perimeter / 4;
    let ss = [...a];
    ss.sort(function(aa, bb) {
        return bb - aa;
    });
    let lengthleft = side;
    while (true) {
        let leftover = [];
        for (let m of ss) {
            if (m > side) {
                return false;
            }
            if (m <= lengthleft) {
                lengthleft -= m;
                if (lengthleft == 0) {
                    sidesleft -= 1;
                    lengthleft = side;
                }
            } else {
                leftover.push(m);
            }
        }
        if (leftover.length == 0) {
            break;
        }
        ss = leftover;
    }
    return sidesleft == 0 && lengthleft == side;
}

if (matchsticksquare([1, 2, 2, 2, 1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!matchsticksquare([2, 2, 2, 4])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!matchsticksquare([2, 2, 2, 2, 4])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (matchsticksquare([3, 4, 1, 4, 3, 1])) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
