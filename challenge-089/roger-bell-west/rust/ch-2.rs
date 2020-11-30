#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_row1() {
    let ms=ms(3,1,1);
    assert_eq!(ms[0].iter().sum::<i64>(),15);
}

#[test]
fn test_row2() {
    let ms=ms(3,1,1);
    assert_eq!(ms[1].iter().sum::<i64>(),15);
}

#[test]
fn test_row3() {
    let ms=ms(3,1,1);
    assert_eq!(ms[2].iter().sum::<i64>(),15);
}

#[test]
fn test_col1() {
    let ms=ms(3,1,1);
    assert_eq!((0..ms.len()).map(|i| ms[i][0]).sum::<i64>(),15);
}

#[test]
fn test_col2() {
    let ms=ms(3,1,1);
    assert_eq!((0..ms.len()).map(|i| ms[i][1]).sum::<i64>(),15);
}

#[test]
fn test_col3() {
    let ms=ms(3,1,1);
    assert_eq!((0..ms.len()).map(|i| ms[i][2]).sum::<i64>(),15);
}

#[test]
fn test_dia1() {
    let ms=ms(3,1,1);
    assert_eq!((0..ms.len()).map(|i| ms[i][i]).sum::<i64>(),15);
}

#[test]
fn test_dia2() {
    let ms=ms(3,1,1);
    assert_eq!((0..ms.len()).map(|i| ms[i][2-i]).sum::<i64>(),15);
}

fn ms(order: usize, start: i64, inc: i64) -> Vec<Vec<i64>> {
    let mut m=vec![vec![0; order]; order];
    let mut x: usize=(order/2)+1;
    let mut y: usize=order/2;
    let mut n=start;
    loop {
        m[x][y]=n;
        n += inc;
        let mut xa=(x+1) % order;
        let mut ya=(y+1) % order;
        if m[xa][ya] > 0 {
            xa=(x+2) % order;
            ya=y;
            if m[xa][ya] > 0 {
                break;
            }
        }
        x=xa;
        y=ya;
    }
    return m;
}
