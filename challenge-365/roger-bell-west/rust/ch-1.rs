#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(alphabetindexdigitsum("abc", 1), 6);
}

#[test]
fn test_ex2() {
    assert_eq!(alphabetindexdigitsum("az", 2), 9);
}

#[test]
fn test_ex3() {
    assert_eq!(alphabetindexdigitsum("cat", 1), 6);
}

#[test]
fn test_ex4() {
    assert_eq!(alphabetindexdigitsum("dog", 2), 8);
}

#[test]
fn test_ex5() {
    assert_eq!(alphabetindexdigitsum("perl", 3), 6);
}

fn alphabetindexdigitsum(a: &str, k: u32) -> u32 {
    let mut st = String::new();
    for c in a.chars() {
        st.push_str(&(c as u32 - 96).to_string());
    }
    let mut v = st.parse::<u32>().unwrap();
    for _ in 0 .. k {
        let mut j = 0;
        while v > 0 {
            j += v % 10;
            v /= 10;
        }
        v = j;
    }
    v
}
