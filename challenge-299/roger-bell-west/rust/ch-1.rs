#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        replacewords(
            vec!["cat", "bat", "rat"],
            "the cattle was rattle by the battery"
        ),
        "the cat was rat by the bat"
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        replacewords(vec!["a", "b", "c"], "aab aac and cac bab"),
        "a a a c b"
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        replacewords(vec!["man", "bike"], "the manager was hit by a biker"),
        "the man was hit by a bike"
    );
}

fn replacewords(ww: Vec<&str>, a: &str) -> String {
    let mut out: Vec<&str> = Vec::new();
    for w in a.split(' ') {
        let mut r = false;
        for lw in &ww {
            if w.starts_with(lw) {
                out.push(*lw);
                r = true;
                break;
            }
        }
        if !r {
            out.push(&&w);
        }
    }
    out.join(" ").to_string()
}
