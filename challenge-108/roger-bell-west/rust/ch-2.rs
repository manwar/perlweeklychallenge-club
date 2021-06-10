#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(bell(10),vec![1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147]);
}

fn bell(count: usize) -> Vec<u64> {
    let mut a: Vec<Vec<u64>>=vec![vec![1]];
    for row in 1..count {
        let mut b: Vec<u64>=vec![*a.last().unwrap().last().unwrap()];
        for col in 1..=row {
            b.push(b[col-1]+&a.last().unwrap()[col-1]);
        }
        a.push(b);
    }
    let mut out: Vec<u64>=vec![];
    for i in a {
        out.push(i[0]);
    }
    return out;
}
