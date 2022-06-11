#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(fibstr("1234", "5678", 51), '7');
}

fn fibstr(aa: &str, bb: &str, limit: usize) -> char {
    let mut a = aa.to_string();
    let mut b = bb.to_string();
    loop {
        let c = a + &b;
        println!("{}", c);
        if c.len() >= limit {
            return c.chars().nth(limit - 1).unwrap();
        }
        a = b;
        b = c;
    }
}
