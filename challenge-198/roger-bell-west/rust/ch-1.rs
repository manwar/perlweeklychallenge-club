#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(maxgap(vec![2, 5, 8, 1]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(maxgap(vec![3]), 0);
}

fn maxgap(l0: Vec<i32>) -> usize {
    if l0.len() < 2 {
        return 0;
    }
    let mut l = l0;
    l.sort();
    let mut q = Vec::new();
    for i in l.windows(2) {
        q.push(i[1] - i[0]);
    }
    let mq = *q.iter().max().unwrap();
    q.into_iter().filter(|i| i == &mq).count()
}
