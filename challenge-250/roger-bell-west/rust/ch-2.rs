#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(alphanumericstringvalue(vec!["perl", "2", "000", "python", "raku"]), 6);
}

#[test]
fn test_ex2() {
    assert_eq!(alphanumericstringvalue(vec!["001", "1", "000", "0001"]), 1);
}

fn alphanumericstringvalue(a: Vec<&str>) -> u32 {
    let mut l: Vec<u32> = Vec::new();
    for n in a {
        let mut p = n.len() as u32;
        if let Ok(k) = n.parse::<u32>() {
            p = k;
        }
        l.push(p);
    }
    return *l.iter().max().unwrap();
}
