#![allow(dead_code)]

use std::env;

fn main() {
    let n = env::args().nth(1).expect("Missing argument n").parse().expect("Bad argument n");

    let num = nth_ugly_number(n);

    println!("{}", num);
}

fn nth_ugly_number(n: usize) -> usize {
    (1..)
        .filter(|i| is_ugly(*i))
        .nth(n - 1)
        .unwrap()
}

fn is_ugly(mut n: usize) -> bool {
    n = divide_all(n, 5);
    n = divide_all(n, 3);
    n = divide_all(n, 2);
    n == 1
}

fn divide_all(n: usize, div: usize) -> usize {
    let l = if div == 2 { (n as f64).log2() } else { (n as f64).log(div as f64) } as u32;
    (1..=l)
        .rev()
        .map(|k| div.pow(k))
        .filter(|kp| n % kp == 0)
        .map(|kp| n / kp)
        .next()
        .unwrap_or(n)
}

#[cfg(test)]
mod tests {
    use crate::*;

    // from assignment

    #[test]
    fn do_test1() {
        assert_eq!(nth_ugly_number(7), 8);
    }

    #[test]
    fn do_test2() {
        assert_eq!(nth_ugly_number(10), 12);
    }
}
