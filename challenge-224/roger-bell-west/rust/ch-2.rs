#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(additivenumber("112358"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(additivenumber("12345"), false);
}

#[test]
fn test_ex3() {
    assert_eq!(additivenumber("199100199"), true);
}

fn exdigits(digits: &Vec<usize>, start: usize, end: usize) -> usize {
    let mut x = 0;
    for i in start..=end {
        x *= 10;
        x += digits[i];
    }
    x
}

fn additivenumber(digitstring: &str) -> bool {
    let digits = digitstring
        .chars()
        .map(|x| x.to_digit(10).unwrap() as usize)
        .collect::<Vec<_>>();
    let mut stack: Vec<(usize, usize, usize)> = Vec::new();
    for i in 0..digits.len() - 2 {
        for j in i + 1..digits.len() - 1 {
            stack.push((0, i, j));
        }
    }
    while stack.len() > 0 {
        let (start_a, end_a, end_b) = stack.pop().unwrap();
        let start_b = end_a + 1;
        let val_ab = exdigits(&digits, start_a, end_a)
            + exdigits(&digits, start_b, end_b);
        let start_c = end_b + 1;
        for end_c in start_c..digits.len() {
            if val_ab == exdigits(&digits, start_c, end_c) {
                if end_c == digits.len() - 1 {
                    return true;
                } else {
                    stack.push((start_b, end_b, end_c));
                    break;
                }
            }
        }
    }
    false
}
