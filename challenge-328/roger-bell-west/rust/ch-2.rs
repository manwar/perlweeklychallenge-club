#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(goodstring("WeEeekly"), "Weekly");
}

#[test]
fn test_ex2() {
    assert_eq!(goodstring("abBAdD"), "");
}

#[test]
fn test_ex3() {
    assert_eq!(goodstring("abc"), "abc");
}

fn goodstring(a: &str) -> String {
    let mut c = a.chars().collect::<Vec<char>>();
    let mut dirty;
    loop {
        dirty = false;
        for i in 0..c.len() - 1 {
            if (c[i].is_ascii_lowercase() && c[i + 1].is_ascii_uppercase())
                || (c[i].is_ascii_uppercase() && c[i + 1].is_ascii_lowercase())
            {
                let mut ca = c[i];
                let mut cb = c[i + 1];
                ca.make_ascii_lowercase();
                cb.make_ascii_lowercase();
                if ca == cb {
                    dirty = true;
                    c.splice(i..=i + 1, []);
                    break;
                }
            }
        }
        if !dirty || c.len() == 0 {
            break;
        }
    }
    c.into_iter().collect()
}
