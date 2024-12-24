#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(largestnumber(vec![20, 3]), 320);
}

#[test]
fn test_ex2() {
    assert_eq!(largestnumber(vec![3, 30, 34, 5, 9]), 9534330);
}

fn largestnumber(a: Vec<u32>) -> u32 {
    let mut ax = a.iter().map(|x| x.to_string()).collect::<Vec<_>>();
    ax.sort_unstable_by(|i, j| {
        let mut ij = String::new();
        ij.push_str(i);
        ij.push_str(j);
        let inumeric = ij.parse::<u32>().unwrap();
        let mut ji = String::new();
        ji.push_str(j);
        ji.push_str(i);
        let jnumeric = ji.parse::<u32>().unwrap();
        inumeric.cmp(&jnumeric)
    });
    ax.reverse();
    ax.join("").parse::<u32>().unwrap()
}
