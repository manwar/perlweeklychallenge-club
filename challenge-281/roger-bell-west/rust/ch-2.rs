#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::{HashSet, VecDeque};

#[test]
fn test_ex1() {
    assert_eq!(knightsmove("g2", "a8"), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(knightsmove("g2", "h2"), 3);
}

fn cs2xy(a: &str) -> (i8, i8) {
    let c = a.chars().collect::<Vec<char>>();
    let x = c[0] as i8 - 'a' as i8;
    let y = c[1] as i8 - '1' as i8;
    (x, y)
}

fn knightsmove(from: &str, to: &str) -> isize {
    let fc = cs2xy(from);
    let tc = cs2xy(to);
    let mut queue: VecDeque<(i8, i8, isize)> = VecDeque::new();
    queue.push_back((fc.0, fc.1, 0));
    let mut seen = HashSet::new();
    while let Some(cc) = queue.pop_front() {
        if cc.0 == tc.0 && cc.1 == tc.1 {
            return cc.2;
        } else {
            for offset in [
                (2, 1),
                (1, 2),
                (2, -1),
                (1, -2),
                (-2, 1),
                (-1, 2),
                (-2, -1),
                (-1, -2),
            ] {
                let x = cc.0 + offset.0;
                let y = cc.1 + offset.1;
                if x >= 0 && x <= 7 && y >= 0 && y <= 7 {
                    if !seen.contains(&(x, y)) {
                        queue.push_back((x, y, cc.2 + 1));
                        seen.insert((x, y));
                    }
                }
            }
        }
    }
    -1
}
