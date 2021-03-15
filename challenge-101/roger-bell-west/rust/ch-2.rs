#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(ot(vec![vec![0,1],vec![1,0],vec![2,2]]),0);
}

#[test]
fn test_ex2() {
    assert_eq!(ot(vec![vec![1,1],vec![-1,1],vec![0,-3]]),1);
}

#[test]
fn test_ex3() {
    assert_eq!(ot(vec![vec![0,1],vec![2,0],vec![-6,0]]),1);
}

fn ot(pp: Vec<Vec<i32>>) -> i32 {
    let mut points=pp.clone();
    points.push(pp[0].clone());
    let mut xp: Vec<i32>=vec![];
    for i in 0..3 {
        xp.push(points[i][0]*(points[i+1][1]-points[i][1])
                -points[i][1]*(points[i+1][0]-points[i][0]));
    }
    xp.sort();
    if xp[0] <= 0 && xp[2] <= 0 {
        return 1;
    }
    if xp[0] >= 0 && xp[2] >= 0 {
        return 1;
    }
    return 0;
}
