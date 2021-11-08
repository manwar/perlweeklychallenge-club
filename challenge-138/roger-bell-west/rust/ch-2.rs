#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(splnum(81),1);
}

#[test]
fn test_ex2() {
    assert_eq!(splnum(9801),1);
}

#[test]
fn test_ex3() {
    assert_eq!(splnum(36),0);
}

fn splnum(n: u32) -> u8 {
    let k=(n as f64).sqrt() as u32;
    if k*k != n {
        return 0
    }
    let d=n.to_string();
    let dl=d.len()-1;
    for s in 1..1<<dl {
        let mut sa=vec![0];
        for i in 0..dl {
            if (s & (1<<i)) > 0 {
                sa.push(i+1);
            }
        }
        sa.push(dl+1);
        let mut c=0;
        for j in 0..sa.len()-1 {
            c+=d[sa[j]..sa[j+1]].to_string().parse::<u32>().unwrap();
        }
        if c==k {
            return 1;
        }
    }
    0
}
