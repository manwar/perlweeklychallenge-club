#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(oddoneout(vec!["abc", "xyz", "tsu"]), 1);
}

#[test]
fn test_ex2() {
    assert_eq!(oddoneout(vec!["rat", "cab", "dad"]), 3);
}

#[test]
fn test_ex3() {
    assert_eq!(oddoneout(vec!["x", "y", "z"]), 0);
}

fn oddoneout(a: Vec<&str>) -> u32 {
    let mut ct = 0;
    for s in a {
        let mut p = s.to_string().chars().collect::<Vec<char>>();
        p.sort();
        let t = p.iter().collect::<String>();
        if s != t {
            ct += 1;
        }
    }
    ct
}
