#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(rn(2),vec![65]);
}

#[test]
fn test_ex2() {
    assert_eq!(rn(6),vec![621770]);
}

#[test]
fn test_ex3() {
    assert_eq!(rn(9),vec![281089082]);
}

fn rn(d: u32) -> Vec<i64> {
    let mut out: Vec<i64>=vec![];
    let mxm: i64=10_i64.pow(d-2)-1;
    for a in [2,4,6,8].iter() {
        for q in [0,2,3,5,7,8].iter() {
            if *a==2 && *q!=2 {
                continue;
            }
            if *a==4 && *q!=0 {
                continue;
            }
            if *a==6 && *q!=0 && *q!=5 {
                continue;
            }
            if *a==8 && *q!=2 && *q!=3 && *q!=7 && *q!=8 {
                continue;
            }
            if d==2 {
                let ts=format!("{:?}{:?}",a,q);
                if is_rare(ts.clone()) {
                    out.push(ts.parse::<i64>().unwrap());
                }
            } else {
                for md in 0..=mxm {
                    let mds=format!("{:0width$}",md,width=(d-2) as usize);
                    let b=mds.chars().nth(0).unwrap().to_digit(10).unwrap() as i32;
                    let p=mds.chars().last().unwrap().to_digit(10).unwrap() as i32;
                    if *a==2 && b!=p {
                        continue;
                    }
                    if *a==4 && (b-p).abs()%2 != 0 {
                        continue;
                    }
                    if *a==6 && (b-p).abs()%2 != 1 {
                        continue;
                    }
                    if *a==8 {
                        if *q==2 && b+p != 9 {
                            continue;
                        }
                        if *q==3 && b-p != 7 && p-b != 3 {
                            continue;
                        }
                        if *q==7 && b+p != 1 && b+p != 11 {
                            continue;
                        }
                        if *q==8 && b!=p {
                            continue;
                        }
                    }
                    let ts=format!("{}{}{}",a,mds,q);
                    if is_rare(ts.clone()) {
                        out.push(ts.parse::<i64>().unwrap());
                    }
                }
            }
        }
    }
    return out
}

fn is_rare(t: String) -> bool {
    let mut d=String::new();
    for b in t.chars().rev() {
        d.push(b);
    }
    let dn=d.parse::<i64>().unwrap();
    let tn=t.parse::<i64>().unwrap();
    if dn >= tn {
        return false;
    }
    for cn in [tn+dn,tn-dn].iter() {
        let cm=cn % 10;
        if cm==2 || cm==3 || cm==7 || cm==8 {
            return false;
        }
        let s=(*cn as f64).sqrt() as i64;
        if s*s != *cn {
            return false;
        }
    }
    return true;
}
