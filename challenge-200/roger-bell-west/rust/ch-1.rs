#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        arithmeticslices(vec![1, 2, 3, 4]),
        vec![vec![1, 2, 3], vec![1, 2, 3, 4], vec![2, 3, 4]]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(arithmeticslices(vec![2]), Vec::<Vec<isize>>::new());
}

fn arithmeticslices(l: Vec<isize>) -> Vec<Vec<isize>> {
    let mut o = Vec::new();
    if l.len() >= 3 {
        for a in 0..=l.len() - 3 {
            let mut valid = false;
            for b in a + 2..=l.len() - 1 {
                let mut v = vec![0; b - a + 1];
                v.copy_from_slice(&l[a..=b]);
                if !valid {
                    for i in 0..=v.len() - 3 {
                        if v[i + 1] - v[i] == v[i + 2] - v[i + 1] {
                            valid = true;
                            break;
                        }
                    }
                }
                if valid {
                    o.push(v);
                }
            }
        }
    }
    o
}
