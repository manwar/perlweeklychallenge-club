#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        nearestvalidpoint(
            3,
            4,
            vec![vec![1, 2], vec![3, 1], vec![2, 4], vec![2, 3]]
        ),
        2
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        nearestvalidpoint(
            2,
            5,
            vec![vec![3, 4], vec![2, 3], vec![1, 5], vec![2, 5]]
        ),
        3
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        nearestvalidpoint(1, 1, vec![vec![2, 2], vec![3, 3], vec![4, 4]]),
        -1
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        nearestvalidpoint(
            0,
            0,
            vec![vec![0, 1], vec![1, 0], vec![0, 2], vec![2, 0]]
        ),
        0
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        nearestvalidpoint(
            5,
            5,
            vec![vec![5, 6], vec![6, 5], vec![5, 4], vec![4, 5]]
        ),
        0
    );
}

fn nearestvalidpoint(x: i32, y: i32, points: Vec<Vec<i32>>) -> isize {
    let mut ix = -1isize;
    let mut minmhd = -1;
    for (i, p) in points.iter().enumerate() {
        if p[0] == x || p[1] == y {
            let mhd = (p[0] - x).abs() + (p[1] - y).abs();
            if minmhd == -1 || mhd < minmhd {
                minmhd = mhd;
                ix = i as isize;
            }
        }
    }
    ix
}
