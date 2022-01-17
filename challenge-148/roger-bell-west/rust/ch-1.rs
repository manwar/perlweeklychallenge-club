#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        eban(100),
        vec![2, 4, 6, 30, 32, 34, 36, 40, 42, 44, 46, 50, 52, 54, 56, 60, 62, 64, 66]
    );
}

fn eban(mx: usize) -> Vec<usize> {
    let units=vec![true,false,true,false,true,false,true,false,false,false];
    let tens=vec![true,false,false,true,true,true,true,false,false,false,false];
    let mut out=Vec::new();
    for i in 0..=mx {
        if tens[i/10] && units[i%10] && i != 0 {
            out.push(i);
        }
    }
    out
}
