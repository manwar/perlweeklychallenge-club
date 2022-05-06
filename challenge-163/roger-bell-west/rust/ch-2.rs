#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(summation(vec![1, 2, 3, 4, 5]), 42);
}

#[test]
fn test_ex2() {
    assert_eq!(summation(vec![1, 3, 5, 7, 9]), 70);
}

fn summation(ls0: Vec<usize>) -> usize {
    let mut ls = ls0;
    while ls.len() > 1 {
        let mut lv: Vec<usize> = Vec::new();
        for i in 1..ls.len() {
            let mut s = 0;
            for j in 1..=i {
                s += ls[j];
            }
            lv.push(s);
        }
        ls = lv;
    }
    ls[0]
}
