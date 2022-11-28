#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(binarystring(2), vec!["00", "01", "10", "11"]);
}

#[test]
fn test_ex2() {
    assert_eq!(binarystring(3), vec!["000", "001", "010", "011", "100", "101", "110", "111"]);
}

fn binarystring(n: usize) -> Vec<String> {
    let mut o = Vec::new();
    for a in 0..(1<<n) {
        o.push(format!("{:0width$b}", a, width = n));
    }
    o
}
