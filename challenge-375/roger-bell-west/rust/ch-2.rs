#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(findkbeauty(240, 2), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(findkbeauty(1020, 2), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(findkbeauty(444, 2), 0);
}

#[test]
fn test_ex4() {
    assert_eq!(findkbeauty(17, 2), 1);
}

#[test]
fn test_ex5() {
    assert_eq!(findkbeauty(123, 1), 2);
}

fn findkbeauty(a: u64, n: usize) -> usize {
    let mut total = 0;
    let c = a.to_string().chars().collect::<Vec<_>>();
    for t in c.windows(n) {
        let tn = t.iter().collect::<String>().parse().unwrap();
        if a.is_multiple_of(tn) {
            total += 1;
        }
    }
    total
}
