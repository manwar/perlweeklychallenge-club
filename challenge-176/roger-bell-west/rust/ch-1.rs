#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(permutable(), 142857);
}

fn n2tab(n: usize) -> Vec<char> {
    let mut a = n.to_string().chars().collect::<Vec<char>>();
    a.sort();
    a
}

fn permutable() -> usize {
    let mut n = 0;
    loop {
        n += 1;
        let base = n2tab(n);
        let mut q = true;
        for k in 2..=6 {
            if n2tab(n * k) != base {
                q = false;
                break;
            }
        }
        if q {
            return n;
        }
    }
}
