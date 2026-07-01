#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sumoffrequencies("banana"), 5);
}

#[test]
fn test_ex2() {
    assert_eq!(sumoffrequencies("teestett"), 7);
}

#[test]
fn test_ex3() {
    assert_eq!(sumoffrequencies("aeiouuaa"), 3);
}

#[test]
fn test_ex4() {
    assert_eq!(sumoffrequencies("rhythm"), 2);
}

#[test]
fn test_ex5() {
    assert_eq!(sumoffrequencies("x"), 1);
}

use counter::Counter;

fn sumoffrequencies(a: &str) -> usize {
    let mut vw = 0;
    let mut cn = 0;
    for (c, n) in a.chars().collect::<Counter<_>>().most_common_ordered() {
        match c {
            'a' | 'e' | 'i' | 'o' | 'u' => {
                if vw == 0 {
                    vw = n;
                }
             },
            _ => {
                if cn == 0 {
                    cn = n;
                }
            }
        };
        if vw > 0 && cn > 0 {
            break;
        }
    }
    vw + cn
}
