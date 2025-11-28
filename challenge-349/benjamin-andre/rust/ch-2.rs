#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn meeting_point(path: &str) -> bool {
    let mut x = 0;
    let mut y = 0;
    for c in path.chars() {
        match c {
            'U' => y += 1,
            'D' => y -= 1,
            'L' => x -= 1,
            'R' => x += 1,
            _ => {}
        }
        if x == 0 && y == 0 {
            return true;
        }
    }
    false
}

#[test]
fn example() {
    assert_eq!(meeting_point("ULD"), false);
    assert_eq!(meeting_point("ULDR"), true);
    assert_eq!(meeting_point("UUURRRDDD"), false);
    assert_eq!(meeting_point("UURRRDDLLL"), true);
    assert_eq!(meeting_point("RRUULLDDRRUU"), true);
}
