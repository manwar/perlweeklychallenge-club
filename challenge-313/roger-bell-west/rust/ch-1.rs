#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(brokenkeys("perl", "perrrl"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(brokenkeys("raku", "rrakuuuu"), true);
}

#[test]
fn test_ex3() {
    assert_eq!(brokenkeys("python", "perl"), false);
}

#[test]
fn test_ex4() {
    assert_eq!(brokenkeys("coffeescript", "cofffeescccript"), true);
}

fn brokenkeys(name: &str, typed: &str) -> bool {
    let nt = name.chars().collect::<Vec<char>>();
    let tt = typed.chars().collect::<Vec<char>>();
    let mut ni = 0;
    let mut ti = 0;
    loop {
        if nt[ni] != tt[ti] {
            return false;
        }
        if ti == tt.len() - 1 {
            break;
        }
        if ni < nt.len() - 1 && nt[ni + 1] == nt[ni] {
            ni += 1;
        } else {
            while ti < tt.len() && tt[ti] == nt[ni] {
                ti += 1;
            }
            if ti == tt.len() {
                break;
            }
            ni += 1;
        }
    }
    true
}
