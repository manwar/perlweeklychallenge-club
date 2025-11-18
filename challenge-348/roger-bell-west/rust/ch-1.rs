#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(stringalike("textbook"), false);
}

#[test]
fn test_ex2() {
    assert_eq!(stringalike("book"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(stringalike("AbCdEfGh"), true);
}

#[test]
fn test_ex4() {
    assert_eq!(stringalike("rhythmmyth"), false);
}

#[test]
fn test_ex5() {
    assert_eq!(stringalike("UmpireeAudio"), false);
 }

fn stringalike(a: &str) -> bool {
    if a.len() % 2 == 1 {
        return false;
    }
    let mut vt = 0i32;
    let mut mode = 1i32;
    let mut av = false;
    for (i, c) in a.to_ascii_lowercase().chars().enumerate() {
        if i == a.len() / 2 {
            mode = -1i32;
        }
        vt += match c {
            'a' | 'e' | 'i' | 'o' | 'u' => {
                    av = true;
                    mode
                    },
            _ => 0,
        };
    }
    av && (vt == 0)
}
