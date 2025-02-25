#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        rightinterval(vec![vec![3, 4], vec![2, 3], vec![1, 2]]),
        vec![-1, 0, 1]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        rightinterval(vec![vec![1, 4], vec![2, 3], vec![3, 4]]),
        vec![-1, 2, -1]
    );
}

#[test]
fn test_ex3() {
    assert_eq!(rightinterval(vec![vec![1, 2]]), vec![-1]);
}

#[test]
fn test_ex4() {
    assert_eq!(
        rightinterval(vec![vec![1, 4], vec![2, 2], vec![3, 4]]),
        vec![-1, 1, -1]
    );
}

fn rightinterval(a: Vec<Vec<u32>>) -> Vec<isize> {
    let ss = a.iter().map(|x| x[0]).collect::<Vec<_>>();
    let mut si = (0..a.len()).collect::<Vec<usize>>();
    si.sort_by(|i, j| a[*i].cmp(&a[*j]));
    let mut out = Vec::new();
    for l in a {
        let ix = si.iter().filter(|&&i| ss[i] >= l[1]).nth(0);
        if let Some(v) = ix {
            out.push(*v as isize);
        } else {
            out.push(-1)
        }
    }
    out
}
