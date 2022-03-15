#! /usr/bin/node

function divisors(n) {
    let ff=[1]
    if (n==1) {
        return ff
    }
    let s=Math.floor(Math.sqrt(n))
    if (s * s == n) {
        ff.push(s)
        s--
    }
    for (let pf=2;pf <= s;pf++) {
        if (n % pf == 0) {
            ff.push(pf)
            ff.push(Math.floor(n/pf))
        }
    }
    return ff
}

function is_weird(n) {
    let dd=divisors(n)
    if (dd.reduce((x,y) => x+y) <= n) {
        return false
    }
    let mlimit=1 << dd.length
    for (let mask=1;mask < mlimit;mask++) {
        let ss=0
        for (let [i, d] of dd.entries()) {
            if ((mask & 1<<i) > 0) {
                ss += d
                if (ss > n) {
                    break
                }
            }
            if (ss==n) {
                return false
            }
        }
    }
    return true
}

if (!is_weird(12)) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (!is_weird(13)) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (is_weird(70)) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
