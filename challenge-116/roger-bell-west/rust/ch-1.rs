#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(ns(1234),vec![1,2,3,4]);
}

#[test]
fn test_ex2() {
    assert_eq!(ns(91011),vec![9,10,11]);
}

#[test]
fn test_ex3() {
    assert_eq!(ns(10203),vec![10203]);
}

#[test]
fn test_ex4() {
    assert_eq!(ns(910911),vec![910,911]);
}

#[test]
fn test_ex5() {
    assert_eq!(ns(9109119),vec![9109119]);
}

fn ns (n: u32) -> Vec<u32> {
    let ns=n.to_string();
    let l=ns.len();
    for sl in 1..l/2+1 {
        let mut i=sl;
        let mut e=vec![ns[0..sl].parse::<u32>().unwrap()];
        loop {
            if l==i {
                break;
            }
            e.push(e.last().unwrap()+1);
            let es=e.last().unwrap().to_string();
            let el=es.len();
            if l-i < el || ns[i..i+el] != es {
                e=vec![];
                break;
            }
            i+=el
        }
        if e.len()>0 {
            return e
        }
    }
    return vec![n];
}
