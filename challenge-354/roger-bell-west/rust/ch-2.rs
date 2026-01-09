#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        shiftgrid(vec![vec![1, 2, 3], vec![4, 5, 6], vec![7, 8, 9]], 1),
        vec![vec![9, 1, 2], vec![3, 4, 5], vec![6, 7, 8]]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        shiftgrid(vec![vec![10, 20], vec![30, 40]], 1),
        vec![vec![40, 10], vec![20, 30]]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        shiftgrid(vec![vec![1, 2], vec![3, 4], vec![5, 6]], 1),
        vec![vec![6, 1], vec![2, 3], vec![4, 5]]
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        shiftgrid(vec![vec![1, 2, 3], vec![4, 5, 6]], 5),
        vec![vec![2, 3, 4], vec![5, 6, 1]]
    );
}

#[test]
fn test_ex5() {
    assert_eq!(shiftgrid(vec![vec![1, 2, 3, 4]], 1), vec![vec![4, 1, 2, 3]]);
}

fn shiftgrid(gi: Vec<Vec<u32>>, k0: usize) -> Vec<Vec<u32>> {
    let wi = gi.concat();
    let k = k0 % wi.len();
    let wo = [wi[wi.len() - k..].to_vec(), wi[0..wi.len() - k].to_vec()]
        .to_vec()
        .concat();
    wo.chunks(gi[0].len()).map(|x| x.to_vec()).collect::<Vec<_>>()
}
