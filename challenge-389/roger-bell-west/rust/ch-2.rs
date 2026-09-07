#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(zigzagsubarray(vec![9, 4, 2, 10, 7, 8, 8, 1, 9]), 5);
}

#[test]
fn test_ex2() {
    assert_eq!(zigzagsubarray(vec![1, 7, 4, 9, 2, 5]), 6);
}

#[test]
fn test_ex3() {
    assert_eq!(zigzagsubarray(vec![1, 2, 3, 4, 5]), 2);
}

#[test]
fn test_ex4() {
    assert_eq!(zigzagsubarray(vec![4, 4, 4]), 1);
}

#[test]
fn test_ex5() {
    assert_eq!(zigzagsubarray(vec![10, 20, 15, 12, 18]), 3);
}

fn zigzagsubarray(a: Vec<i32>) -> usize {
    let mut mx = std::cmp::min(a.len(), 1);
    for i in 0..a.len() {
        let mut o = 0;
        let mut lastdir = 0;
        for j in i..a.len() {
            let mut thisdir = 0;
            if j > i {
                if a[j] > o {
                    thisdir = 1;
                    mx = std::cmp::max(mx, 2);
                } else if a[j] < o {
                    thisdir = -1;
                    mx = std::cmp::max(mx, 2);
                }
            }
            if (j > i && thisdir == 0) || (j > i + 1 && thisdir * lastdir != -1)
            {
                break;
            }
            o = a[j];
            lastdir = thisdir;
            mx = std::cmp::max(mx, j - i + 1);
        }
    }
    mx
}
