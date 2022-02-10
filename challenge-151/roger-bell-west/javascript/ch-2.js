#! /usr/bin/node

function plan(houses) {
    let terminal=houses.length-2;
    let b=[[0]];
    let reward=0;
    while (b.length > 0) {
        let c=b.pop();
        let c1=c[c.length-1];
        if (c1 >= terminal) {
            let r=c.reduce((x,y) => x+houses[y],0);
            if (r > reward) {
                reward = r;
            }
        } else {
            for (let n=c1+2; n <= c1+3; n++) {
                if (n >= houses.length) {
                    break;
                }
                let j=[...c];
                j.push(n);
                b.push(j);
            }
        }
    }
    return reward;
}


if (plan([2, 4, 5]) == 7) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (plan([4, 2, 3, 6, 5, 3]) == 13) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");

