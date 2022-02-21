#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        leftfactorial(10),
        vec![1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114]
    );
}

fn leftfactorial(mx: u32) -> Vec<u32> {
    let mut out = Vec::new();
    let mut fact = 1;
    let mut sum = 0;
    for i in 0..mx {
        if i > 0 {
            fact *= i;
        }
        sum += fact;
        out.push(sum);
    }
    out
}
