#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(consecutiveodds(vec![1, 5, 3, 6]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(consecutiveodds(vec![2, 6, 3, 5]), false);
}

#[test]
fn test_ex3() {
    assert_eq!(consecutiveodds(vec![1, 2, 3, 4]), false);
}

#[test]
fn test_ex4() {
    assert_eq!(consecutiveodds(vec![2, 3, 5, 7]), true);
}

fn consecutiveodds(a: Vec<usize>) -> bool {
    let mut i = 0;
    for v in a {
        if v % 2 == 1 {
            i += 1;
            if i >= 3 {
                return true;
            }
        } else {
            i = 0;
        }
    }
    false
}
