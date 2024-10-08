#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(luhnalgorithm("17893729974"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(luhnalgorithm("4137 8947 1175 5904"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(luhnalgorithm("4137 8974 1175 5904"), false);
}

fn luhnalgorithm(a: &str) -> bool {
    let mut digits = a
        .chars()
        .filter(|x| *x >= '0' && *x <= '9')
        .map(|x| x.to_digit(10).unwrap())
        .collect::<Vec<u32>>();
    let payload = digits.pop().unwrap();
    digits.reverse();
    for i in (0..digits.len()).step_by(2) {
        digits[i] *= 2;
        if digits[i] > 9 {
            digits[i] -= 9;
        }
    }
    10 - (digits.into_iter().sum::<u32>() % 10) == payload
}
