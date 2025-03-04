#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(groupdigitsum("111122333", 3), "359");
}

#[test]
fn test_ex2() {
    assert_eq!(groupdigitsum("1222312", 2), "76");
}

#[test]
fn test_ex3() {
    assert_eq!(groupdigitsum("100012121001", 4), "162");
}

fn groupdigitsum(a: &str, sz: usize) -> String {
    let mut s = a.to_string();
    let mut n = 0;
    loop {
        let mut t = String::new();
        for (i, c) in s.chars().enumerate() {
            n += c.to_digit(10).unwrap();
            if i == s.len() - 1 || (i + 1) % sz == 0 {
                t.push_str(&n.to_string());
                n = 0;
            }
        }
        s = t.to_string();
        if s.len() <= sz {
            break;
        }
    }
    s
}
