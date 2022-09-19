#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(checkdamm(5724), true);
}

#[test]
fn test_ex2() {
    assert_eq!(checkdamm(5727), false);
}

fn damm(n: usize) -> usize {
    let tab = vec![
        vec![0, 3, 1, 7, 5, 9, 8, 6, 4, 2],
        vec![7, 0, 9, 2, 1, 5, 4, 8, 6, 3],
        vec![4, 2, 0, 6, 8, 7, 1, 3, 5, 9],
        vec![1, 7, 5, 0, 9, 8, 3, 4, 2, 6],
        vec![6, 1, 2, 3, 0, 4, 5, 9, 7, 8],
        vec![3, 6, 7, 4, 2, 0, 9, 5, 8, 1],
        vec![5, 8, 6, 9, 7, 2, 0, 1, 3, 4],
        vec![8, 9, 4, 5, 3, 6, 2, 0, 1, 7],
        vec![9, 4, 3, 8, 6, 1, 7, 2, 0, 5],
        vec![2, 5, 8, 1, 4, 3, 6, 7, 9, 0],
    ];
    let mut c = 0;
    for digit in n.to_string().chars() {
        let dd = digit.to_digit(10).unwrap() as usize;
        c = tab[c][dd];
    }
    c
}

fn checkdamm(n: usize) -> bool {
    damm(n) == 0
}
