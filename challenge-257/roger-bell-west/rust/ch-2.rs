#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        reducedrowechelon(vec![vec![1, 1, 0], vec![0, 1, 0], vec![0, 0, 0]]),
        false
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        reducedrowechelon(vec![
            vec![0, 1, -2, 0, 1],
            vec![0, 0, 0, 1, 3],
            vec![0, 0, 0, 0, 0],
            vec![0, 0, 0, 0, 0]
        ]),
        true
    );
}

#[test]
fn test_ex3() {
    assert_eq!(
        reducedrowechelon(vec![
            vec![1, 0, 0, 4],
            vec![0, 1, 0, 7],
            vec![0, 0, 1, -1]
        ]),
        true
    );
}

#[test]
fn test_ex4() {
    assert_eq!(
        reducedrowechelon(vec![
            vec![0, 1, -2, 0, 1],
            vec![0, 0, 0, 0, 0],
            vec![0, 0, 0, 1, 3],
            vec![0, 0, 0, 0, 0]
        ]),
        false
    );
}

#[test]
fn test_ex5() {
    assert_eq!(
        reducedrowechelon(vec![vec![0, 1, 0], vec![1, 0, 0], vec![0, 0, 0]]),
        false
    );
}

#[test]
fn test_ex6() {
    assert_eq!(
        reducedrowechelon(vec![
            vec![4, 0, 0, 0],
            vec![0, 1, 0, 7],
            vec![0, 0, 1, -1]
        ]),
        false
    );
}

#[test]
fn test_ex7() {
    assert_eq!(
        reducedrowechelon(vec![
            vec![1, 0, 0, 4],
            vec![1, 0, 0, 7],
            vec![0, 0, 1, -1]
        ]),
        false
    );
}

#[test]
fn test_ex8() {
    assert_eq!(
        reducedrowechelon(vec![
            vec![1, -2, 0, 4],
            vec![0, 1, 0, 7],
            vec![0, 0, 1, -1]
        ]),
        false
    );
}

fn reducedrowechelon(a: Vec<Vec<i32>>) -> bool {
    let mut leadingone = Vec::new();
    for row in a.iter() {
        let mut lp = -1;
        for (cn, &cell) in row.iter().enumerate() {
            if cell == 1 {
                lp = cn as i32;
                break;
            } else if cell != 0 {
                return false;
            }
        }
        leadingone.push(lp);
    }
    while leadingone[leadingone.len() - 1] == -1 {
        leadingone.pop();
    }
    let mut c = leadingone.clone();
    c.sort();
    if c[0] == -1 {
        return false;
    }
    if c != leadingone {
        return false;
    }
    for i in c {
        let mut col = a.iter().map(|r| r[i as usize]).collect::<Vec<i32>>();
        col.sort();
        if col[col.len() - 1] != 1 || col[col.len() - 2] != 0 || col[0] != 0 {
            return false;
        }
    }
    true
}
