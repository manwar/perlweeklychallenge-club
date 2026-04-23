#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(scramblestring("abc", "acb"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(scramblestring("abcd", "cdba"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(scramblestring("hello", "hiiii"), false);
}

#[test]
fn test_ex4() {
    assert_eq!(scramblestring("ateer", "eater"), true);
}

#[test]
fn test_ex5() {
    assert_eq!(scramblestring("abcd", "bdac"), false);
}

fn scram(a: &str) -> Vec<String> {
    if a.len() < 2 {
        return vec![a.to_string()];
    }
    let mut out: Vec<String> = Vec::new();
    for sp in 1 .. a.len() {
        let suba = scram(&a[0 .. sp]);
        let subb = scram(&a[sp ..]);
        for na in &suba {
            for nb in &subb {
                let mut s = String::new();
                s.push_str(&na.clone());
                s.push_str(&nb.clone());
                out.push(s);
                let mut r = String::new();
                r.push_str(&nb.clone());
                r.push_str(&na.clone());
                out.push(r);
            }
        }
    }
    out
}

fn scramblestring(a: &str, b: &str) -> bool {
    let out = scram(a);
    out.contains(&b.to_string())
}
