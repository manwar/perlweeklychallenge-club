#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(pattern132(vec![3, 1, 4, 2]), vec![1, 4, 2]);
}

#[test]
fn test_ex2() {
    assert_eq!(pattern132(vec![1, 2, 3, 4]), vec![]);
}

#[test]
fn test_ex3() {
    assert_eq!(pattern132(vec![1, 3, 2, 4, 6, 5]), vec![1, 3, 2]);
}

#[test]
fn test_ex4() {
    assert_eq!(pattern132(vec![1, 3, 4, 2]), vec![1, 3, 2]);
}

fn pattern132(l: Vec<isize>) -> Vec<isize> {
    let mut o = Vec::new();
    'outer: for a in 0..=l.len() - 3 {
        for b in a + 1..=l.len() - 2 {
            if l[a] < l[b] {
                for c in b + 1..=l.len() - 1 {
                    if l[b] > l[c] && l[a] < l[c] {
                        o = vec![l[a], l[b], l[c]];
                        break 'outer;
                    }
                }
            }
        }
    }
    o
}
