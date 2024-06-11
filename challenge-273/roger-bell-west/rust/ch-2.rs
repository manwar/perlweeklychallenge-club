#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(baftera("aabb"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(baftera("abab"), false);
}

#[test]
fn test_ex3() {
    assert_eq!(baftera("aaa"), false);
}

#[test]
fn test_ex4() {
    assert_eq!(baftera("bbb"), true);
}

fn baftera(a: &str) -> bool {
    let firstb = a.find('b');
    if firstb == None {
        return false;
    }
    let lasta = a.rfind('a');
    if lasta == None {
        return true;
    }
    lasta.unwrap() < firstb.unwrap()
}
