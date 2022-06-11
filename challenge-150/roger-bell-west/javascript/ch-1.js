#! /usr/bin/node

function fibstr(aa,bb,limit) {
    let a=aa;
    let b=bb;
    while (true) {
        let c = a + b;
        console.log(c);
        if (c.length >= limit) {
            return c.slice(limit-1,limit);
        }
        a = b;
        b = c;
    }
}

if (fibstr("1234","5678",51) == "7") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");

