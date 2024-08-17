#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(goodinteger(12344456), 444);
}

#[test]
fn test_ex2() {
    assert_eq!(goodinteger(1233334), -1);
}

#[test]
fn test_ex3() {
    assert_eq!(goodinteger(10020003), 0);
}

fn goodinteger(a: u32) -> i32 {
    let winsize = 3;
    let d = a.to_string().chars().collect::<Vec<char>>();
    for (offset, cc) in d.windows(winsize).enumerate() {
        if cc[0] == cc[1] && cc[1] == cc[2] {
            if (offset == 0 || d[offset - 1] != cc[0])
                && (offset == d.len() - winsize || d[offset + winsize] != cc[2])
            {
                return cc
                    .into_iter()
                    .collect::<String>()
                    .parse::<i32>()
                    .unwrap();
            }
        }
    }
    -1
}
