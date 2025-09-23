#! /usr/bin/node

"use strict"

function ascendingnumbers(a) {
    let prev = null;
    for (let c of a.split(" ")) {
        let n = parseInt(c, 10);
        if (!isNaN(n)) {
            if (prev !== null && prev >= n) {
                return false;
            }
            prev = n;
        }
    }
    return true;
}

if (ascendingnumbers('The cat has 3 kittens 7 toys 10 beds')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!ascendingnumbers('Alice bought 5 apples 2 oranges 9 bananas')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (ascendingnumbers('I ran 1 mile 2 days 3 weeks 4 months')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!ascendingnumbers('Bob has 10 cars 10 bikes')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (ascendingnumbers('Zero is 0 one is 1 two is 2')) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
