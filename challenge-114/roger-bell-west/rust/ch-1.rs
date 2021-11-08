#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(npn(1234),1331);
}

#[test]
fn test_ex2() {
    assert_eq!(npn(999),1001);
}

fn npn (n: i64) -> i64 {
    let nn=n.to_string();
    let mut ii: String;
    let mut m: i8;
    let l=nn.len();
    if l % 2 == 0 {
        ii=nn[0..l/2].to_string();
        m=1;
    } else {
        ii=nn[0..(l+1)/2].to_string();
        m=0;
    }
    let mut i: i64=ii.parse().unwrap();
    let mut pn: i64=0;
    while pn <= n {
        ii=i.to_string();
        let f=ii.len();
        i+=1;
        if i.to_string().len() > f {
            if m==0 {
                m=1;
                i=10i64.pow((f-1) as u32);
            } else {
                m=0;
                i=10i64.pow(f as u32);
            }
        }
        ii=i.to_string();
        let k: String=ii.chars().rev().collect();
        let mut pns=ii.clone();
        if m==0 {
            pns.push_str(&k[1..]);
        } else {
            pns.push_str(&k);
        }
        pn=pns.parse().unwrap();
    }
    return pn;
}
