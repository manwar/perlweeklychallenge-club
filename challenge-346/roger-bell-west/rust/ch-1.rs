#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(longestparenthesis("(()())"), 6);
}

#[test]
fn test_ex2() {
    assert_eq!(longestparenthesis(")()())"), 4);
}

#[test]
fn test_ex3() {
    assert_eq!(longestparenthesis("((()))()(((()"), 8);
}

#[test]
fn test_ex4() {
    assert_eq!(longestparenthesis("))))((()("), 2);
}

#[test]
fn test_ex5() {
    assert_eq!(longestparenthesis("()(()"), 2);
}

fn longestparenthesis(aa: &str) -> usize {
    let a = aa.chars().collect::<Vec<char>>();
    let mut ml = 0;
    for l in 0 .. a.len() {
        for r in l .. a.len() {
            let mut depth = 0i32;
            let mut valid = true;
            for i in l ..= r {
                if a[i] == '(' {
                    depth += 1;
                } else {
                    depth -= 1;
                    if depth < 0 {
                        valid = false;
                        break;
                    }
                }
            }
            if depth != 0 {
                valid = false;
            }
            if valid {
                ml = std::cmp::max(ml, r - l + 1);
            }
        }
    }
    ml
}
