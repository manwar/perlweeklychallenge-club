#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        sortbyonebits(vec![0, 1, 2, 3, 4, 5, 6, 7, 8]),
        vec![0, 1, 2, 4, 8, 3, 5, 6, 7]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        sortbyonebits(vec![1024, 512, 256, 128, 64]),
        vec![64, 128, 256, 512, 1024]
    );
}

fn sortbyonebits(a0: Vec<u32>) -> Vec<u32> {
    let mut a = a0.clone();
    a.sort_unstable();
    a.sort_by_cached_key(|x| x.count_ones());
    a
}
