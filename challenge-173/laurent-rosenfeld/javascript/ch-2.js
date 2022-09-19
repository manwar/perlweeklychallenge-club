let s = BigInt (2)
let one = BigInt (1)
console.log(s + " ");
for (let i = 1; i <= 9; i++) {
    s = s * (s - one) + one
    console.log(s + " ");
}
