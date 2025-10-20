#!/bin/sh
//usr/bin/env rustc --test $0 -o kachow && ./kachow --nocapture; rm -f kachow ; exit

fn array_formation(source: &[&[i32]], target: &[i32]) -> bool {
    let mut pos = 0;
    while pos < target.len() {
        let chunk = source
            .iter()
            .find(|&&s| s.len() <= target.len() - pos && s == &target[pos..pos + s.len()]);
        match chunk {
            Some(c) => pos += c.len(),
            None => return false,
        }
    }
    true
}

#[test]
fn example() {
    assert_eq!(array_formation(&[&[2, 3], &[1], &[4]], &[1, 2, 3, 4]), true);
    assert_eq!(array_formation(&[&[1, 3], &[2, 4]], &[1, 2, 3, 4]), false);
    assert_eq!(
        array_formation(&[&[9, 1], &[5, 8], &[2]], &[5, 8, 2, 9, 1]),
        true
    );
    assert_eq!(array_formation(&[&[1], &[3]], &[1, 2, 3]), false);
    assert_eq!(array_formation(&[&[7, 4, 6]], &[7, 4, 6]), true);
}
