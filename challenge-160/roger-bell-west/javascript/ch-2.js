#! /usr/bin/node

function equilibriumindex (s) {
    let sm=s.reduce((x,y) => x+y, 0)
    let sa=0
    for (let [i,v] of s.entries()) {
        sa += v
        if (sa == sm) {
            return i
        }
        sa += v
    }
    return -1
}

if (equilibriumindex([1,3,5,7,9]) == 3) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (equilibriumindex([1,2,3,4,5]) == -1) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (equilibriumindex([2,4,2]) == 1) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
