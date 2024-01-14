#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(concatenationvalue(vec![6, 12, 25, 1]), 1286);
}

#[test]
fn test_ex2() {
    assert_eq!(concatenationvalue(vec![10, 7, 31, 5, 2, 2]), 489);
}

#[test]
fn test_ex3() {
    assert_eq!(concatenationvalue(vec![1, 2, 10]), 112);
}

fn concat(a0: u32, b0: u32) -> u32 {
    if b0 == 0 {
        return 10 * a0;
    }
    let mut a = a0;
    let mut b = b0;
    while b > 0 {
        a *= 10;
        b /= 10;
    }
    a + b0
}

fn concatenationvalue(a: Vec<u32>) -> u32 {
    let mut t = 0;
    for i in 0 ..= (a.len()-1) / 2 {
        let j = a.len() - 1 - i;
        if j == i {
            t += a[i];
        } else {
            t += concat(a[i], a[j]);
        }
    }
    t
}
