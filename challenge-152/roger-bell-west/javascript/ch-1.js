#! /usr/bin/node

function tsp (tree) {
    let mp=0;
    for (let r of tree) {
        mp += Math.min(...r);
    }
    return mp;
}

if (tsp([[1],[5,3],[2,3,4],[7,1,0,2],[6,4,5,2,8]]) == 8) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (tsp([[5],[2,3],[4,1,4],[0,1,2,3],[7,2,4,1,9]]) == 9) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");

