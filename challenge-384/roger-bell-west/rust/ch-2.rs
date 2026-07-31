#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(specialbinarysubstrings("0101"), vec!["01", "10", "01"]);
}

#[test]
fn test_ex2() {
    assert_eq!(specialbinarysubstrings("000111"), vec!["000111", "0011", "01"]);
}

#[test]
fn test_ex3() {
    assert_eq!(specialbinarysubstrings("000011"), vec!["0011", "01"]);
}

#[test]
fn test_ex4() {
    assert_eq!(
        specialbinarysubstrings("10011100"),
        vec!["10", "0011", "01", "1100", "10"]
    );
}

#[test]
fn test_ex5() {
    assert_eq!(specialbinarysubstrings("00000"), Vec::<String>::new());
}

fn specialbinarysubstrings(a: &str) -> Vec<String> {
    let mut out = Vec::new();
    let ac = a.chars().collect::<Vec<_>>();
    for i in 0..ac.len() - 1 {
        for j in (i + 1..ac.len()).step_by(2) {
            let mut lastchar = 'x';
            let mut switches = 0;
            let mut balance = 0i32;
            let mut outstr = String::new();
            for ct in i..=j {
                if ac[ct] != lastchar {
                    switches += 1;
                    lastchar = ac[ct];
                }
                if ac[ct] == '0' {
                    balance -= 1;
                } else {
                    balance += 1;
                }
                outstr.push(ac[ct]);
            }
            if balance == 0 && switches == 2 {
                out.push(outstr);
            }
        }
    }
    out
}
