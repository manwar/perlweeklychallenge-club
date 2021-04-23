#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(ds(1,3),"0.(3)");
}

#[test]
fn test_ex2() {
    assert_eq!(ds(1,2),"0.5");
}

#[test]
fn test_ex3() {
    assert_eq!(ds(5,66),"0.0(75)");
}

fn ds(n: i64, d: i64) -> String {
    let mut quotient: String=format!("{}",n/d);
    quotient.push_str(".");
    let mut c: i64=10*(n % d);
    while c > 0 && c < d {
        c *= 10;
        quotient.push_str("0");
    }
    let mut digits: Vec<char>=vec![];
    let mut passed: HashMap<i64,usize>=HashMap::new();
    let mut i: usize=0;
    loop {
        if passed.contains_key(&c) {
            let pc=*(passed.get(&c).unwrap());
            let cycle=&digits[pc..digits.len() as usize].to_vec();
            let mut result: String=quotient;
            if pc>0 {
                for ix in 0..pc {
                    result.push(digits[ix]);
                }
            }
            if cycle.len()>1 || cycle[0] != '0' {
                result.push('(');
                for cc in cycle {
                    result.push(*cc);
                }
                result.push(')');
            }
            let cc=result.pop().unwrap();
            if cc != '.' {
                result.push(cc);
            }
            return result;
        }
        let q: i64=c/d;
        let r=c % d;
        passed.insert(c,i);
        digits.push(std::char::from_digit(q as u32,10).unwrap());
        i += 1;
        c=10*r;
    }
}
