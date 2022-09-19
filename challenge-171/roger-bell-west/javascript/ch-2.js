#! /usr/bin/node

"use strict"

let f = function(x) { return x+1 };
let g = function(x) { return x*2 };

function compose(f1,f2) {
    return function(x) { return f1(f2(x)) };
}

let h = compose(f,g);

for (let i = 1; i <= 10; i++) {
    if (f(g(i)) == h(i)) {
        process.stdout.write("Pass");
    } else {
        process.stdout.write("FAIL");
    }
    process.stdout.write(" ");
}
process.stdout.write("\n");
