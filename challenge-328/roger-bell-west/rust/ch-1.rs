#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(replaceall("a?z"), "abz");
}

#[test]
fn test_ex2() {
    assert_eq!(replaceall("pe?k"), "peak");
}

#[test]
fn test_ex3() {
    assert_eq!(replaceall("gra?te"), "grabte");
}

fn replaceall(a: &str) -> String {
    let mut ci = a.chars().collect::<Vec<char>>();
    let l = a.len() - 1;
    for i in 0..=l {
        let c = ci[i];
        if c == '?' {
            let mut r = 'a';
            while (i > 0 && ci[i - 1] == r) || (i < l && ci[i + 1] == r) {
                r = std::char::from_u32(r as u32 + 1).unwrap();
            }
            ci[i] = r;
        }
    }
    ci.into_iter().collect()
}
