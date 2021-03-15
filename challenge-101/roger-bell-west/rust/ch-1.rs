#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(pas(vec![1,2,3,4]),vec![vec![1,2],vec![4,3]]);
}

#[test]
fn test_ex2() {
    assert_eq!(pas(vec![1,2,3,4,5,6]),vec![vec![1,2,3],vec![6,5,4]]);
}

#[test]
fn test_ex3() {
    assert_eq!(pas(vec![1,2,3,4,5,6,7,8,9,10,11,12]),vec![vec![1,2,3,4],vec![10,11,12,5],vec![9,8,7,6]]);
}

fn pas(aa: Vec<i32>) -> Vec<Vec<i32>> {
    let mut a=aa;
    a.reverse();
    let n=a.len();
    let mut f2: usize=(n as f64).sqrt() as usize;
    let f1: usize;
    loop {
        if n % f2 == 0 {
            f1=n/f2;
            break;
        }
        f2 -= 1;
    }
    let mut out: Vec<Vec<i32>>=vec![vec![0;f1]; f2];
    let mut x: usize=0;
    let mut y: usize=0;
    let mut minx: usize=0;
    let mut maxx: usize=f1-1;
    let mut miny: usize=1;
    let mut maxy: usize=f2-1;
    let mut first: bool=true;
    'arr: loop {
        while x < maxx {
            if first {
                first=false;
            } else {
                x += 1;
            }
            out[y][x]=a.pop().unwrap();
            if a.len()==0 {
                break 'arr;
            }
        }
        if maxx > 0 {
            maxx -= 1;
        }
        while y < maxy {
            y += 1;
            out[y][x]=a.pop().unwrap();
            if a.len()==0 {
                break 'arr;
            }
        }
        if maxy > 0 {
            maxy -= 1;
        }
        while x > minx {
            x -= 1;
            out[y][x]=a.pop().unwrap();
            if a.len()==0 {
                break 'arr;
            }
        }
        minx += 1;
        while y > miny {
            y -= 1;
            out[y][x]=a.pop().unwrap();
            if a.len()==0 {
                break 'arr;
            }
        }
        miny += 1;
    }
    return out;
}
