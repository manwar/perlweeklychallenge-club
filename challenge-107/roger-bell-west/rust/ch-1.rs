#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sdn(3),vec![1210, 2020, 21200]);
}

fn sdn(count: usize) -> Vec<u64> {
    let mut r: Vec<u64>=vec![];
    let mut n: u64=10;
    while r.len() < count {
        let mut ns: Vec<usize>=vec![];
        let mut d: Vec<usize>=vec![0;10];
        for i in n.to_string().chars() {
            let k=i.to_digit(10).unwrap() as usize;
            ns.push(k);
            d[k] += 1;
        }
        let mut sd: bool=true;
        for i in 0..ns.len() {
            if d[i] != ns[i] {
                sd=false;
                break;
            }
        }
        if sd && ns.len()<10 {
            for i in ns.len()..10 {
                if d[i] != 0 {
                    sd=false;
                    break;
                }
            }
        }
        if sd {
            r.push(n);
        }
        n += 10;
    }
    return r
}
