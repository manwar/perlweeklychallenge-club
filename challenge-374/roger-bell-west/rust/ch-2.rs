#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(largestsamedigitsnumber("6777133339"), 3333);
}

#[test]
fn test_ex2() {
    assert_eq!(largestsamedigitsnumber("1200034"), 4);
}

#[test]
fn test_ex3() {
    assert_eq!(largestsamedigitsnumber("44221155"), 55);
}

#[test]
fn test_ex4() {
    assert_eq!(largestsamedigitsnumber("88888"), 88888);
}

#[test]
fn test_ex5() {
    assert_eq!(largestsamedigitsnumber("11122233"), 222);
}

fn largestsamedigitsnumber(a: &str) -> u64 {
    for l in (1..=a.len()).rev() {
        for n in (1..=9).rev() {
            let test = n.to_string().repeat(l);
            if a.contains(&test) {
                return test.parse().unwrap();
            }
        }
    }
    0
}
