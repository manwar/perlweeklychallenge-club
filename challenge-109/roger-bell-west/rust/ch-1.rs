#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(chowla(20),vec![0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21]);
}

fn chowla(count: usize) -> Vec<usize> {
    let mut a: Vec<usize>=vec![];
    for n in 1..=count {
        let mut s=0;
        for i in 2..=n/2 {
            if n % i == 0 {
                s += i
            }
        }
        a.push(s);
    }
    return a;
}
