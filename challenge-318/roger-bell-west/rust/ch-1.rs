#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(groupposition("abccccd"), vec!["cccc"]);
}

#[test]
fn test_ex2() {
    assert_eq!(groupposition("aaabcddddeefff"), vec!["aaa", "dddd", "fff"]);
}

#[test]
fn test_ex3() {
    assert_eq!(groupposition("abcdd"), Vec::<String>::new());
}

fn groupposition(a: &str) -> Vec<String> {
    let mut mx: Vec<(char, usize)> = Vec::new();
    let mut lc = 'z';
    for (i, c) in a.chars().enumerate() {
        if i == 0 {
            lc = (c as u8 + 1) as char;
        }
        if lc == c {
            let mc = mx.len();
            mx[mc - 1].1 += 1;
        } else {
            mx.push((c, 1));
            lc = c;
        }
    }
    let mut out: Vec<String> = Vec::new();
    for ms in mx {
        if ms.1 >= 3 {
            let mut s = String::with_capacity(ms.1);
            for _ in 0..ms.1 {
                s.push(ms.0);
            }
            out.push(s);
        }
    }
    out
}
