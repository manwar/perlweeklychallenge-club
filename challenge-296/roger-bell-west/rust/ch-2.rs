#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(matchsticksquare(vec![1, 2, 2, 2, 1]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(matchsticksquare(vec![2, 2, 2, 4]), false);
}

#[test]
fn test_ex3() {
    assert_eq!(matchsticksquare(vec![2, 2, 2, 2, 4]), false);
}

#[test]
fn test_ex4() {
    assert_eq!(matchsticksquare(vec![3, 4, 1, 4, 3, 1]), true);
}

fn matchsticksquare(a: Vec<u32>) -> bool {
    let perimeter: u32 = a.iter().sum();
    if perimeter % 4 != 0 {
        return false;
    }
    let side = perimeter / 4;
    let mut ss = a.clone();
    ss.sort();
    ss.reverse();
    let mut sidesleft: i32 = 4;
    let mut lengthleft = side;
    loop {
        let mut leftover = Vec::new();
        for m in ss {
            if m > side {
                return false;
            }
            if m <= lengthleft {
                lengthleft -= m;
                if lengthleft == 0 {
                    sidesleft -= 1;
                    lengthleft = side;
                }
            } else {
                leftover.push(m);
            }
        }
        if leftover.len() == 0 {
            break;
        }
        ss = leftover;
    }
    sidesleft == 0 && lengthleft == side
}
