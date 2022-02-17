#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        tsp(vec![
            vec![1],
            vec![5, 3],
            vec![2, 3, 4],
            vec![7, 1, 0, 2],
            vec![6, 4, 5, 2, 8]
        ]),
        8
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        tsp(vec![
            vec![5],
            vec![2, 3],
            vec![4, 1, 4],
            vec![0, 1, 2, 3],
            vec![7, 2, 4, 1, 9]
        ]),
        9
    );
}

fn tsp(tree: Vec<Vec<u32>>) -> u32 {
    let mut mp = 0;
    for r in tree {
        mp += r.iter().min().unwrap();
    }
    return mp;
}
