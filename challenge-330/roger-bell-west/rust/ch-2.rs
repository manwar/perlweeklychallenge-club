#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(titlecapital("PERL IS gREAT"), "Perl is Great");
}

#[test]
fn test_ex2() {
    assert_eq!(titlecapital("THE weekly challenge"), "The Weekly Challenge");
}

#[test]
fn test_ex3() {
    assert_eq!(titlecapital("YoU ARE A stAR"), "You Are a Star");
}

fn titlecapital(a: &str) -> String {
    let mut out = Vec::new();
    for w in a.split(' ') {
        let mut p = w.to_ascii_lowercase();
        if p.len() > 2 {
            let mut c = p.chars().collect::<Vec<char>>();
            c[0].make_ascii_uppercase();
            p = c.into_iter().collect();
        }
        out.push(p);
    }
    out.join(" ")
}
