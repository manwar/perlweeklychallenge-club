// To compile and run:
// $ rustc ch-1.rs
// $ ./ch-1 100
// 13015

use std::env;

fn gcd(a: u32, b: u32) -> u32 {
    let mut x = a;
    let mut y = b;

    while y != 0 {
        let t = y;
        y = x % y;
        x = t;
    }

    return x;
}

fn main() {
    let args: Vec<String> = env::args().collect();

    let n;
    if args.len() == 2 {
        n = args[1].parse().unwrap();
    }
    else {
        n = 3;
    }

    let mut s = 0;
    for x in 1 .. (n + 1) {
        for y in (x + 1) .. (n + 1) {
            s += gcd(x, y);
        }
    }

    println!("{}", s);
}
