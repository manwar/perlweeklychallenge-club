#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sip(vec![1,2,3,4],3),2);
}

#[test]
fn test_ex2() {
    assert_eq!(sip(vec![1,3,5,7],6),3);
}

#[test]
fn test_ex3() {
    assert_eq!(sip(vec![12,14,16,18],10),0);
}

#[test]
fn test_ex4() {
    assert_eq!(sip(vec![11,13,15,17],19),4);
}

fn sip(n: Vec<i32>, t: i32) -> usize {
    if n[n.len()-1] < t {
        return n.len();
    }
    let mut l: usize = 0;
    let mut h: usize = n.len()-1;
    let mut m: usize;
    while h-l > 1 {
        m=(h+l)/2;
        if n[m]==t {
            return m;
        } else if n[m] > t {
            h=m;
        } else {
            l=m;
        }
    }
    if n[l] >= t {
        return l;
    }
    return h;
}
