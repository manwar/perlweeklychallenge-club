#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(binaryreflection(vec![3, 6, 12]), vec![3, 6, 12]);
}

#[test]
fn test_ex2() {
    assert_eq!(binaryreflection(vec![1, 2, 4, 8]), vec![1, 2, 4, 8]);
}

#[test]
fn test_ex3() {
    assert_eq!(binaryreflection(vec![7, 8, 9, 10]), vec![8, 10, 7, 9]);
}

#[test]
fn test_ex4() {
    assert_eq!(binaryreflection(vec![5, 9, 15, 17]), vec![5, 9, 15, 17]);
}

#[test]
fn test_ex5() {
    assert_eq!(binaryreflection(vec![11, 13, 14, 19]), vec![14, 13, 11, 19]);
}

fn reflect(a: u32) -> u32 {
    let mut p = Vec::new();
    let mut am = a;
    loop {
        p.push(am % 2);
        am /= 2;
        if am == 0 {
            break;
        }
    }
    let mut ar = 0;
    let mut s = p.len();
    for n in p {
        s -= 1;
        ar += n << s;
    }
    ar
}

fn binaryreflection(ax: Vec<u32>) -> Vec<u32> {
    let k = ax.iter().map(|x| reflect(*x)).collect::<Vec<u32>>();
    let mut i = (0..ax.len()).collect::<Vec<usize>>();
    i.sort_unstable_by(|a, b| ax[*a].cmp(&ax[*b]));
    i.sort_by(|a, b| k[*a].cmp(&k[*b]));
    i.iter().map(|x| ax[*x]).collect::<Vec<_>>()
}
