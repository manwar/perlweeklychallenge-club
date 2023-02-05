#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(widestvalley(vec![1, 5, 5, 2, 8]), vec![5, 5, 2, 8]);
}

#[test]
fn test_ex2() {
    assert_eq!(widestvalley(vec![2, 6, 8, 5]), vec![2, 6, 8]);
}

#[test]
fn test_ex3() {
    assert_eq!(
        widestvalley(vec![9, 8, 13, 13, 2, 2, 15, 17]),
        vec![13, 13, 2, 2, 15, 17]
    );
}

#[test]
fn test_ex4() {
    assert_eq!(widestvalley(vec![2, 1, 2, 1, 3]), vec![2, 1, 2]);
}

#[test]
fn test_ex5() {
    assert_eq!(
        widestvalley(vec![1, 3, 3, 2, 1, 2, 3, 3, 2]),
        vec![3, 3, 2, 1, 2, 3, 3]
    );
}

fn widestvalley(a: Vec<usize>) -> Vec<usize> {
    let mut av = Vec::new();
    let mut ac = Vec::new();
    let mut l = 0;
    for &v in &a {
        if v == l {
            *ac.last_mut().unwrap() += 1;
        } else {
            av.push(v);
            ac.push(1);
            l = v;
        }
    }
    let mut s = Vec::new();
    let mut e = Vec::new();
    let mut c = 0;
    for i in 0..=av.len() - 1 {
        if i == 0
            || i == av.len() - 1
            || (av[i - 1] < av[i] && av[i] > av[i + 1])
        {
            s.push(c);
            e.push(c + ac[i] - 1);
        }
        c += ac[i];
    }
    let mut out = Vec::new();
    for i in 0..=s.len() - 2 {
        if e[i + 1] - s[i] + 1 > out.len() {
            out = a[s[i]..=e[i + 1]].to_vec();
        }
    }
    out
}
