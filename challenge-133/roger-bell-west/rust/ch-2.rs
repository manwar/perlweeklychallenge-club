#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(smith(10),vec![4, 22, 27, 58, 85, 94, 121, 166, 202, 265]);
}

fn smith(ccount: u32) -> Vec<u32> {
    let mut count=ccount;
    let mut o=vec![];
    let mut c=1;
    loop {
        c+= 1;
        let ff=factor(c);
        if ff.len()==1 {
            continue;
        }
        if sumofdigits(vec![c]) == sumofdigits(ff) {
            o.push(c);
            count-= 1;
            if count<=0 {
                break;
            }
        }
    }
    o
}

fn factor (nn: u32) -> Vec<u32> {
    let mut n=nn;
    let mut f=vec![];
    let mut ft=2;
    while n>1 {
        if n % ft == 0 {
            f.push(ft);
            n /= ft;
        } else {
            ft+= 1;
            if ft%2 == 0 {
                ft+= 1;
            }
        }
    }
    f
}

fn sumofdigits(kk: Vec<u32>) -> u32 {
    let mut s=0;
    for k in kk {
        let mut l=k;
        while l>0 {
            s+=l % 10;
            l /= 10;
        }
    }
    s
}
