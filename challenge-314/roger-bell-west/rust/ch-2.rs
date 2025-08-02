#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sortcolumn(vec!["swpc", "tyad", "azbe"]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(sortcolumn(vec!["cba", "daf", "ghi"]), 1);
}

#[test]
fn test_ex3() {
    assert_eq!(sortcolumn(vec!["a", "b", "c"]), 0);
}

fn sortcolumn(a: Vec<&str>) -> usize {
    let mut vv: Vec<Vec<char>> = Vec::new();
    for (i, s) in a.iter().enumerate() {
        for (j, c) in s.chars().enumerate() {
            if i == 0 {
                vv.push(Vec::new());
            }
            vv[j].push(c);
        }
    }
    let mut tot = 0;
    for x in vv {
        let mut y = x.clone();
        y.sort();
        if x != y {
            tot += 1;
        }
    }
    tot
}
