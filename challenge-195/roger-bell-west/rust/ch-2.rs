#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(mostfrequenteven(vec![1, 1, 2, 6, 2]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(mostfrequenteven(vec![1, 3, 5, 7]), -1);
}

#[test]
fn test_ex3() {
    assert_eq!(mostfrequenteven(vec![6, 4, 4, 6, 1]), 4);
}

fn mostfrequenteven(l: Vec<usize>) -> isize {
    let mut f: HashMap<usize, usize> = HashMap::new();
    for n in &l {
        if *n % 2 == 0 {
            let en = f.entry(*n).or_insert(0);
            *en += 1;
        }
    }
    if f.len() > 0 {
        let m = f.values().max().unwrap();
        let mut l =
            f.keys().copied().filter(|i| f[i] == *m).collect::<Vec<usize>>();
        l.sort();
        l[0] as isize
    } else {
        -1
    }
}
