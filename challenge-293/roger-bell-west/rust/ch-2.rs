#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(boomerang(vec![vec![1, 1], vec![2, 3], vec![3, 2]]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(boomerang(vec![vec![1, 1], vec![2, 2], vec![3, 3]]), false);
}

#[test]
fn test_ex3() {
    assert_eq!(boomerang(vec![vec![1, 1], vec![1, 2], vec![2, 3]]), true);
}

#[test]
fn test_ex4() {
    assert_eq!(boomerang(vec![vec![1, 1], vec![1, 2], vec![1, 3]]), false);
}

#[test]
fn test_ex5() {
    assert_eq!(boomerang(vec![vec![1, 1], vec![2, 1], vec![3, 1]]), false);
}

#[test]
fn test_ex6() {
    assert_eq!(boomerang(vec![vec![0, 0], vec![2, 3], vec![4, 5]]), true);
}

fn boomerang(a: Vec<Vec<i32>>) -> bool {
    let mut delta = Vec::new();
    // coincident points
    for ij in 0 ..= 1 {
        for ik in ij + 1 ..= 2 {
            if a[ij][0] == a[ik][0] && a[ij][1] == a[ik][1] {
                return false;
            }
        }
        delta.push(vec![a[ij + 1][0] - a[0][0], a[ij + 1][1] - a[0][1]]);
    }
    // all on the same vertical line
    if delta[0][0] == 0 && delta[1][0] == 0 {
        return false;
    }
    // just one vertical line
    if delta[0][0] == 0 || delta[1][0] == 0 {
        return true;
    }
    let m = delta[0][1] as f64 / delta[0][0] as f64;
    let c = a[0][1] as f64 - a[0][0] as f64 * m;
    a[2][1] as f64 != a[2][0] as f64 * m + c
}
