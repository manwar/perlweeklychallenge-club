#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(meetingpoint("ULD"), false);
}

#[test]
fn test_ex2() {
    assert_eq!(meetingpoint("ULDR"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(meetingpoint("UUURRRDDD"), false);
}

#[test]
fn test_ex4() {
    assert_eq!(meetingpoint("UURRRDDLLL"), true);
}

#[test]
fn test_ex5() {
    assert_eq!(meetingpoint("RRUULLDDRRUU"), true);
}

fn meetingpoint(a: &str) -> bool {
    let mut x = 0i32;
    let mut y = 0i32;
    for c in a.chars() {
        match c {
            'R' => {
                x += 1;
            }
            'L' => {
                x -= 1;
            }
            'U' => {
                y += 1;
            }
            'D' => {
                y -= 1;
            }
            _ => {}
        };
        if x == 0 && y == 0 {
            return true;
        }
    }
    false
}
