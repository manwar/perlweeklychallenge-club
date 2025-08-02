#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        weakestrows(vec![
            vec![1, 1, 0, 0, 0],
            vec![1, 1, 1, 1, 0],
            vec![1, 0, 0, 0, 0],
            vec![1, 1, 0, 0, 0],
            vec![1, 1, 1, 1, 1]
        ]),
        vec![2, 0, 3, 1, 4]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        weakestrows(vec![
            vec![1, 0, 0, 0],
            vec![1, 1, 1, 1],
            vec![1, 0, 0, 0],
            vec![1, 0, 0, 0]
        ]),
        vec![0, 2, 3, 1]
    );
}

fn weakestrows(a: Vec<Vec<u32>>) -> Vec<usize> {
    let mut p = (0..a.len()).collect::<Vec<usize>>();
    let b: Vec<u32> = a.iter().map(|n| n.iter().sum()).collect();
    p.sort_by(|l, r| b[*l].cmp(&b[*r]));
    p
}
