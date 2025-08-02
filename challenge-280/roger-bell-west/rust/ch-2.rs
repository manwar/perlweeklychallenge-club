#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(countasterisks("p|*e*rl|w**e|*ekly|"), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(countasterisks("perl"), 0);
}

#[test]
fn test_ex3() {
    assert_eq!(countasterisks("th|ewe|e**|k|l***ych|alleng|e"), 5);
}

fn countasterisks(a: &str) -> u32 {
    let mut out = 0;
    let mut active = true;
    for c in a.chars() {
        match c {
            '|' => active = !active,
            '*' => {
                if active {
                    out += 1
                }
            }
            _ => {}
        }
    }
    out
}
