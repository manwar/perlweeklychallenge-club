#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(formatphonenumber("1-23-45-6"), "123-456");
}

#[test]
fn test_ex2() {
    assert_eq!(formatphonenumber("1234"), "12-34");
}

#[test]
fn test_ex3() {
    assert_eq!(formatphonenumber("12 345-6789"), "123-456-789");
}

#[test]
fn test_ex4() {
    assert_eq!(formatphonenumber("123 4567"), "123-45-67");
}

#[test]
fn test_ex5() {
    assert_eq!(formatphonenumber("123 456-78"), "123-456-78");
}

fn formatphonenumber(a: &str) -> String {
    let mut pure = Vec::<char>::new();
    for c in a.chars() {
        if c.is_ascii_digit() {
            pure.push(c);
        }
    }
    let mut left = pure.len();
    let mut out = Vec::<char>::new();
    let mut i = 0;
    if left > 4 {
        for c in &pure {
            out.push(*c);
            i += 1;
            left -= 1;
            if i % 3 == 0 {
                out.push('-');
                if left <= 4 {
                    break;
                }
            }
        }
    }
    if left == 4 {
        out.push(pure[i]);
        out.push(pure[i + 1]);
        out.push('-');
        i += 2;
    }
    for p in i..pure.len() {
        out.push(pure[p]);
    }
    out.into_iter().collect()
}
