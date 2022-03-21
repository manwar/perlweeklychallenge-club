#! /usr/bin/node
function brazilian(n) {
    for (let b=2;b < n-1;b++) {
        let nn = n
        let braz = true
        let digit = nn % b
        while (nn > 0) {
            if (digit == nn % b) {
                nn = Math.floor(nn/b)
            } else {
                braz = false
                break
            }
        }
        if (braz) {
            return true
        }
    }
    return false
}

if (brazilian(7)) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (!brazilian(6)) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (brazilian(8)) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");
