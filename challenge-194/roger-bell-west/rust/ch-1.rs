#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(digitalclock("?5:00"), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(digitalclock("?3:00"), 2);
}

#[test]
fn test_ex3() {
    assert_eq!(digitalclock("1?:00"), 9);
}

#[test]
fn test_ex4() {
    assert_eq!(digitalclock("2?:00"), 3);
}

#[test]
fn test_ex5() {
    assert_eq!(digitalclock("12:?5"), 5);
}

#[test]
fn test_ex6() {
    assert_eq!(digitalclock("12:5?"), 9);
}

fn digitalclock(hhmm0: &str) -> u8 {
    let i = hhmm0.find('?').unwrap();
    let hhmm = hhmm0.chars().collect::<Vec<char>>();
    if i == 0 {
        if hhmm[1] <= '3' {
            return 2;
        }
        return 1;
    } else if i == 1 {
        if hhmm[0] < '2' {
            return 9;
        }
        return 3;
    } else if i == 3 {
        return 5;
    } else if i == 4 {
        return 9;
    }
    0
}
