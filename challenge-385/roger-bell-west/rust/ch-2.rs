#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(outermostparentheses("()()()"), "");
}

#[test]
fn test_ex2() {
    assert_eq!(outermostparentheses("(((())))"), "((()))");
}

#[test]
fn test_ex3() {
    assert_eq!(outermostparentheses("(()())(())"), "()()()");
}

#[test]
fn test_ex4() {
    assert_eq!(outermostparentheses("()((()))()"), "(())");
}

#[test]
fn test_ex5() {
    assert_eq!(outermostparentheses("(()(()))(()())"), "()(())()()");
}

fn outermostparentheses(a: &str) -> String {
    let mut d = 0;
    let mut out = String::new();
    for c in a.chars() {
        match c {
            '(' => {
                d += 1;
                if d > 1 {
                    out.push(c);
                }
            },
            ')' => {
                d -= 1;
                if d > 0 {
                    out.push(c);
                }
            },
            _ => panic!("Bad char"),
        }
    }
    out
}
