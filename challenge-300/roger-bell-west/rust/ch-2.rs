#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(nestedarray(vec![5, 4, 0, 3, 1, 6, 2]), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(nestedarray(vec![0, 1, 2]), 1);
}

fn nestedarray(a: Vec<usize>) -> usize {
    let mut arr = 0;
    for i in 0..a.len() {
        let mut trail = Vec::new();
        let mut j = i;
        loop {
            j = a[j];
            if trail.contains(&j) {
                break;
            }
            trail.push(j);
        }
        arr = arr.max(trail.len());
    }
    arr
}
