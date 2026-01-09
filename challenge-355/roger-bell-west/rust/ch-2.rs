#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(mountainarray(vec![1, 2, 3, 4, 5]), false);
}

#[test]
fn test_ex2() {
    assert_eq!(mountainarray(vec![0, 2, 4, 6, 4, 2, 0]), true);
}

#[test]
fn test_ex3() {
    assert_eq!(mountainarray(vec![5, 4, 3, 2, 1]), false);
}

#[test]
fn test_ex4() {
    assert_eq!(mountainarray(vec![1, 3, 5, 5, 4, 2]), false);
}

#[test]
fn test_ex5() {
    assert_eq!(mountainarray(vec![1, 3, 2]), true);
}

fn mountainarray(a: Vec<u32>) -> bool {
    let mut state = 0;
    for b in a.windows(2) {
        if b[1] > b[0] {
            match state {
                0 | 1 => state = 1,
                _ => return false,
            };
        } else if b[1] < b[0] {
            match state {
                1 | 2 => state = 2,
                _ => return false,
            };
        } else {
            return false;
        }
    }
    state == 2
}
