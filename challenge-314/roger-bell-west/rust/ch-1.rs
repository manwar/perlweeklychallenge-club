#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(equalstrings(vec!["abc", "abb", "ab"]), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(equalstrings(vec!["ayz", "cyz", "xyz"]), -1);
}

#[test]
fn test_ex3() {
    assert_eq!(equalstrings(vec!["yza", "yzb", "yzc"]), 3);
}

fn equalstrings(a: Vec<&str>) -> isize {
    let mut ca = a
        .iter()
        .map(|x| x.chars().collect::<Vec<char>>())
        .collect::<Vec<Vec<char>>>();
    ca.sort();
    ca.dedup();
    let mmlen = ca.iter().map(|x| x.len()).min().unwrap();
    let mut si = 0;
    for i in 0..mmlen {
        si = i;
        for s in 1..ca.len() {
            if ca[0][i] != ca[s][i] {
                if i == 0 {
                    return -1;
                }
                si -= 1;
                break;
            }
        }
    }
    (a.iter().map(|x| x.len()).sum::<usize>() - a.len() * (si + 1)) as isize
}
