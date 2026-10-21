#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(trionicarray(vec![1, 3, 5, 4, 2, 6, 8]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(trionicarray(vec![1, 4, 4, 2, 1, 3, 5]), false);
}

#[test]
fn test_ex3() {
    assert_eq!(trionicarray(vec![2, 10, 3, 1, 9]), true);
}

#[test]
fn test_ex4() {
    assert_eq!(trionicarray(vec![1, 2, 3, 4, 3, 2, 1]), false);
}

#[test]
fn test_ex5() {
    assert_eq!(trionicarray(vec![1, 3, 2, 4, 1, 5, 2]), false);
}

#[test]
fn test_ex6() {
    assert_eq!(trionicarray(vec![1, 3, 6, 4, 2, 7, 8, 4]), false);
}

fn trionicarray(a: Vec<u32>) -> bool {
    let mut state = 0;
    let mut prev = a[0];
    for n in a.iter().skip(1) {
        let mut dir = 0i32;
        if *n > prev {
            dir = 1;
        } else if *n < prev {
            dir = -1;
        }
        if dir == 0 {
            return false;
        }
        match state {
            0 => {
                if dir == 1 {
                    state = 1;
                } else {
                    return false;
                }
            }
            1 => {
                if dir == -1 {
                    state = 2;
                }
            }
            2 => {
                if dir == 1 {
                    state = 3;
                }
            }
            3 => {
                if dir == -1 {
                    return false;
                }
            }
            _ => {
                panic!["impossible state"];
            }
        }
        prev = *n;
    }
    state == 3
}
