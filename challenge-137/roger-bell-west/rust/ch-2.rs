#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(lychrel(56),0);
}

#[test]
fn test_ex2() {
    assert_eq!(lychrel(57),0);
}

#[test]
fn test_ex3() {
    assert_eq!(lychrel(59),0);
}

#[test]
fn test_ex4() {
    assert_eq!(lychrel(196),-1);
}

fn lychrel(nn: i32) -> i32 {
    let mut n=nn;
    for _ in 1..100 {
        let m=n.to_string().chars().rev().collect::<String>().parse::<i32>().unwrap();
        if m==n {
            return 0;
        }
        n+=m;
        if n > 10000000 {
            break;
        }
    }
    -1
}
