#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(is_wigglesorted(vec![1,5,1,1,6,4]), false);
}

#[test]
fn test_ex2() {
    assert_eq!(is_wigglesorted(vec![1,6,1,5,1,4]), true);
}

#[test]
fn test_ex3() {
    assert_eq!(is_wigglesorted(vec![1,3,2,2,3,1]), false);
}

#[test]
fn test_ex4() {
    assert_eq!(is_wigglesorted(vec![2,3,1,3,1,2]), true);
}

#[test]
fn test_ex5() {
    assert_eq!(is_wigglesorted(vec![1,3,2,2,3,1]), false);
}

#[test]
fn test_ex6() {
    assert_eq!(is_wigglesorted(wigglesort(vec![1,5,1,1,6,4])), true);
}

#[test]
fn test_ex7() {
    assert_eq!(is_wigglesorted(wigglesort(vec![1,3,2,2,3,1])), true);
}

#[test]
fn test_ex8() {
    assert_eq!(is_wigglesorted(wigglesort(vec![1,3,2,2,2,3,1])), true);
}

fn is_wigglesorted(l: Vec<isize>) -> bool {
    for i in 0..l.len()-1 {
        if i % 2 == 0 {
            if l[i] >= l[i+1] {
                return false;
            }
        } else {
            if l[i] <= l[i+1] {
                return false;
            }
        }
    }
    true
}

fn wigglesort(l: Vec<isize>) -> Vec<isize> {
    let mut a = l;
    a.sort();
    let le = a.len();
    let p = le / 2;
    let mut b = a.split_off(p);
    let mut i = 0;
    let mut o = Vec::new();
    if le % 2 == 1 {
        o.push(b[0]);
        b.remove(0);
        i = 1;
    }
    for j in i .. le {
        if j % 2 == 0 {
            o.push(a.pop().unwrap());
        } else {
            o.push(b.pop().unwrap());
        }
    }
    o
}
