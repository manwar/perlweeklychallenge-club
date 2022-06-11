#! /usr/bin/node

function ls(base) {
    let max=0;
    for(let i=base; i>0; i--) {
        max *= base;
        max += i;
    }
    let t=Math.floor(Math.sqrt(max));
    let digits="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    while (true) {
        let s=t*t;
        let v=true;
        let c=Array.from(Array(base),_ => 0);
        let dg=[];
        while (s > 0) {
            let d=s % base;
            c[d]++;
            if (c[d] > 1) {
                v=false;
                break;
            }
            s=Math.floor(s/base);
            dg.unshift(digits[d]);
        }
        if (v) {
            return dg.join("");
        }
        t--;
    }
}

if (ls(2) == "1") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (ls(4) == "3201") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (ls(10) == "9814072356") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (ls(12) == "B8750A649321") {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");

