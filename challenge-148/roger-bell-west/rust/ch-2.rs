#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        cardano(5),
        vec![
            [2,1,5],
            [5,1,52],
            [5,2,13],
            [8,1,189],
            [8,3,21]
        ]);
}

fn cardano(ct: u32) -> Vec<[u32;3]> {
    let mut out: Vec<[u32;3]>=Vec::new();
    let mut k=0;
    let mut cn=0;
    loop {
        let a=3*k+2;
        let b2c=(k+1)*(k+1)*(8*k+5);
        let mut b=0;
        let mut b2=0;
        let mut inc=1;
        loop {
            b += 1;
            b2 += inc;
            inc += 2;
            if b2 > b2c {
                break;
            }
            if b2c % b2 == 0 {
                out.push([a,b,b2c/b2]);
                cn += 1;
                if cn >= ct {
                    break;
                }
            }
        }
        if cn >= ct {
            break;
        }
        k += 1;
    }
    out
}
