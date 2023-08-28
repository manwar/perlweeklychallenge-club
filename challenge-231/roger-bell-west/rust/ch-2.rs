#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        seniorcitizens(vec![
            "7868190130M7522",
            "5303914400F9211",
            "9273338290F4010"
        ]),
        2
    );
}

#[test]
fn test_ex2() {
    assert_eq!(seniorcitizens(vec!["1313579440F2036", "2921522980M5644"]), 0);
}

fn seniorcitizens(a: Vec<&str>) -> u32 {
    let mut p = 0;
    for n in a {
        let c = n.chars().collect::<Vec<_>>();
        if c[11] >= '6' {
            p += 1;
        }
    }
    p
}
