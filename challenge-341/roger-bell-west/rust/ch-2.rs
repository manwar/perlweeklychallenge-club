#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(reverseprefix("programming", "g"), "gorpramming");
}

#[test]
fn test_ex2() {
    assert_eq!(reverseprefix("hello", "h"), "hello");
}

#[test]
fn test_ex3() {
    assert_eq!(reverseprefix("abcdefghij", "h"), "hgfedcbaij");
}

#[test]
fn test_ex4() {
    assert_eq!(reverseprefix("reverse", "s"), "srevere");
}

#[test]
fn test_ex5() {
    assert_eq!(reverseprefix("perl", "r"), "repl");
}

fn reverseprefix(a: &str, f: &str) -> String {
    let mut c = a.chars().collect::<Vec<_>>();
    if let Some(p) = a.find(&f) {
        let mut jr = vec!['0'; p + 1];
        jr.copy_from_slice(&c[0..=p]);
        jr.reverse();
        for (i, ch) in jr.into_iter().enumerate() {
            c[i] = ch;
        }
    }
    c.into_iter().collect()
}
