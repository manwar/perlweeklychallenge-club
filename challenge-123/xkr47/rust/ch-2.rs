#![allow(dead_code)]

use std::env;

fn main() {
    let args = env::args().skip(1).take(8).map(|i| i.parse::<i32>().unwrap()).collect::<Vec<_>>();
    assert_eq!(args.len(), 8, "Wrong number of arguments, expected 8");

    let sq = is_square([(args[0], args[1]), (args[2], args[3]), (args[4], args[5]), (args[6], args[7])]);

    println!("{}", sq);
}

fn is_square(c: [(i32, i32); 4]) -> i8 {
    let vx1 = c[1].0 - c[0].0;
    let vy1 = c[1].1 - c[0].1;
    let vx2 = c[2].0 - c[0].0;
    let vy2 = c[2].1 - c[0].1;
    let vx3 = c[3].0 - c[0].0;
    let vy3 = c[3].1 - c[0].1;
    if vx1 + vx3 == vx2 && vy1 + vy3 == vy2 { 1 } else { 0 }
}

#[cfg(test)]
mod tests {
    use crate::*;

    // from assignment

    #[test]
    fn do_test1() {
        assert_eq!(is_square([(10, 20), (20, 20), (20, 10), (10, 10)]), 1);
    }

    #[test]
    fn do_test2() {
        assert_eq!(is_square([(12, 24), (16, 10), (20, 12), (18, 16)]), 0);
    }
}
