#! /usr/bin/node

function factorion (input) {
    if (input==0) {
        return false;
    }
    let fd=[1];
    let ff=1;
    for (let i=1; i<=9; i++) {
        ff *= i;
        fd.push(ff);
    }
    let working=input;
    let dsum=0;
    while (working > 0) {
        dsum += fd[working%10];
        working=Math.floor(working/10);
    }
    return (input == dsum);
}

if (factorion(145)) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (!factorion(125)) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");

