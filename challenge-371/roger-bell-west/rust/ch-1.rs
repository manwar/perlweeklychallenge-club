#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(missingletter("a c ? g i"), "e");
}

#[test]
fn test_ex2() {
    assert_eq!(missingletter("a d ? j m"), "g");
}

#[test]
fn test_ex3() {
    assert_eq!(missingletter("a e ? m q"), "i");
}

#[test]
fn test_ex4() {
    assert_eq!(missingletter("a c f ? k"), "h");
}

#[test]
fn test_ex5() {
    assert_eq!(missingletter("b e g ? l"), "j");
}

fn missingletter(a: &str) -> String {
    let c = a
        .chars()
        .filter(|x| !x.is_whitespace())
        .map(|x| x as i8)
        .collect::<Vec<i8>>();
    let mut d = Vec::new();
    for i in c.windows(2) {
        if i[0] == 63 || i[1] == 63 {
            d.push(0);
        } else {
            d.push(i[1] - i[0]);
        }
    }
    for (n, delta) in d.iter().enumerate() {
        if *delta == 0 {
            let ch;
            if n < 2 {
                ch = c[n + 2] - d[n + 2];
            } else {
                ch = c[n] + d[n - 2];
            }
            return (ch.abs() as u8 as char).to_string();
        }
    }
    "".to_string()
}
