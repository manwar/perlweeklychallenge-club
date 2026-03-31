#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(validtimes("?2:34"), 3);
}

#[test]
fn test_ex2() {
    assert_eq!(validtimes("?4:?0"), 12);
}

#[test]
fn test_ex3() {
    assert_eq!(validtimes("??:??"), 1440);
}

#[test]
fn test_ex4() {
    assert_eq!(validtimes("?3:45"), 3);
}

#[test]
fn test_ex5() {
    assert_eq!(validtimes("2?:15"), 4);
}

fn validtimes(a: &str) -> usize {
    let mut combinator = Vec::new();
    for (i, c) in a.chars().enumerate() {
        if let Some(n) = c.to_digit(10) {
            combinator.push(vec![n]);
        } else {
            match i {
                0 => {
                    combinator.push((0..=2).collect::<Vec<_>>());
                }
                1 | 4 => {
                    combinator.push((0..=9).collect::<Vec<_>>());
                }
                3 => {
                    combinator.push((0..=5).collect::<Vec<_>>());
                }
                _ => {}
            };
        }
    }
    if combinator.len() != 4 {
        return 0;
    }
    let minutes = combinator[2].len() * combinator[3].len();
    let mut ct = 0;
    for ax in &combinator[0] {
        for bx in &combinator[1] {
            if ax * 10 + bx <= 23 {
                ct += 1;
            }
        }
    }
    ct * minutes
}
