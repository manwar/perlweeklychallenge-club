#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(toeplitzmatrix(vec![vec![4, 3, 2, 1], vec![5, 4, 3, 2], vec![6, 5, 4, 3]]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(toeplitzmatrix(vec![vec![1, 2, 3], vec![3, 2, 1]]), false);
}

fn toeplitzmatrix(a: Vec<Vec<i32>>) -> bool {
    let ym = (a.len() - 1) as isize;
    let xm = (a[0].len() - 1) as isize;
    let mut toeplitz = true;
    for xb in (1 - xm) ..= (ym - 1) {
        let mut init = true;
        let mut tv = 0;
        for xi in xb ..= (xb + xm) {
            if xi >= 0 && xi <= xm {
                let x = xi as usize;
                let yi = xi - xb;
                if yi >= 0 && yi <= ym {
                    let y = yi as usize;
                    if init {
                        init = false;
                        tv = a[y][x];
                    } else if a[y][x] != tv {
                        toeplitz = false;
                        break;
                    }
                }
            }
        }
        if !toeplitz {
            break;
        }
    }
    toeplitz
}
