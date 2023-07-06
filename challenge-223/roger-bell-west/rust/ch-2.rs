#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(boxcoins(vec![3, 1, 5, 8]), 167);
}

#[test]
fn test_ex2() {
    assert_eq!(boxcoins(vec![1, 5]), 10);
}

fn boxcoins(ints: Vec<i32>) -> i32 {
    let mut mx: i32 = 0;
    let mut stack: Vec<(Vec<i32>, i32)> = Vec::new();
    stack.push((ints, 0));
    while stack.len() > 0 {
        let (t, tot) = stack.pop().unwrap();
        if tot > mx {
            mx = tot;
        }
        for i in 0..t.len() {
            let mut p: i32 = t[i];
            if i > 0 {
                p *= t[i - 1];
            }
            if i < t.len() - 1 {
                p *= t[i + 1];
            }
            let stot = tot + p;
            let mut tt = Vec::new();
            for ix in 0..t.len() {
                if i != ix {
                    tt.push(t[ix]);
                }
            }
            stack.push((tt, stot));
        }
    }
    mx
}
