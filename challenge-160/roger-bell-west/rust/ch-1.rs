#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        fim(5),
        "Five is four, four is magic."
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        fim(7),
        "Seven is five, five is four, four is magic."
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        fim(6),
        "Six is three, three is five, five is four, four is magic."
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        fim(4),
        "Four is magic."
    );
}

fn fim(n0: usize) -> String {
    let words=vec!["zero","one","two","three","four",
                   "five","six","seven","eight","nine"];
    let mut n = n0;
    let mut p = Vec::new();
    loop {
        let mut s = format!("{} is ",words[n]);
        if n==4 {
            s.push_str("magic.");
            p.push(s);
            break;
        } else {
            n = words[n].len();
            s.push_str(words[n]);
            p.push(s);
        }
    }
    upfirst(p.join(", "))
}

// borrowed from Shepmaster
// https://stackoverflow.com/questions/38406793/why-is-capitalizing-the-first-letter-of-a-string-so-convoluted-in-rust
fn upfirst(s: String) -> String {
    let mut c = s.chars();
    match c.next() {
        None => String::new(),
        Some(f) => f.to_uppercase().collect::<String>() + c.as_str(),
    }
}
