// Test run:
// $ node ch-1.js 100
// 13015

let n = process.argv.length == 3 ? process.argv[2] : 3;

let s = 0;
for (let x = 1; x <= n; x++) {
    for (let y = x + 1; y <= n; y++) {
        s += gcd(x, y);
    }
}

console.log(s);

function gcd(a, b) {
    while (b) {
        let t = b;
        b = a % b;
        a = t;
    }

    return a;
}
