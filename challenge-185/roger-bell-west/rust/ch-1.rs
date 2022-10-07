#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(recomposemac("1ac2.34f0.b1c2"), "1a:c2:34:f0:b1:c2");
}

#[test]
fn test_ex2() {
    assert_eq!(recomposemac("abc1.20f1.345a"), "ab:c1:20:f1:34:5a");
}

fn recomposemac(inp: &str) -> String {
    let mut out = String::new();
    let mut count: u8 = 0;
    for c in inp.chars() {
        match c {
            '0'..='9' | 'a'..='f' => {
                if count == 2 {
                    out.push(':');
                    count = 0;
                }
                count += 1;
                out.push(c);
            }
            _ => {}
        }
    }
    out
}
