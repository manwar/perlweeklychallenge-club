#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        arrangebox(vec![vec![1, 3], vec![3, 5], vec![6, 8], vec![2, 4]]),
        4
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        arrangebox(vec![
            vec![4, 5],
            vec![4, 6],
            vec![6, 7],
            vec![2, 3],
            vec![4, 3]
        ]),
        3
    );
}

#[test]
fn test_ex3() {
    assert_eq!(arrangebox(vec![vec![5, 5], vec![5, 5], vec![5, 5]]), 1);
}

#[test]
fn test_ex4() {
    assert_eq!(
        arrangebox(vec![
            vec![2, 100],
            vec![3, 200],
            vec![4, 300],
            vec![5, 50],
            vec![5, 400]
        ]),
        4
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        arrangebox(vec![
            vec![10, 20],
            vec![15, 10],
            vec![20, 30],
            vec![12, 18],
            vec![16, 25]
        ]),
        3
    );
}

fn arrangebox(a0: Vec<Vec<u32>>) -> usize {
    let mut a = a0.clone();
    a.sort();
    let mut stack = Vec::new();
    let mut mx = 1;
    for i in 0..a.len() {
        stack.push((i, 1));
    }
    while let Some((ix, pm)) = stack.pop() {
        if pm > mx {
            mx = pm;
        }
        for j in ix + 1..a.len() {
            if a[ix][0] < a[j][0] && a[ix][1] < a[j][1] {
                stack.push((j, pm + 1));
            }
        }
    }
    mx
}
