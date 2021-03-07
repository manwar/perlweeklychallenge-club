#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(hcs(1),"#");
}

#[test]
fn test_ex2() {
    assert_eq!(hcs(2),"2#");
}

#[test]
fn test_ex3() {
    assert_eq!(hcs(3),"#3#");
}

#[test]
fn test_ex4() {
    assert_eq!(hcs(10),"#3#5#7#10#");
}

#[test]
fn test_ex5() {
    assert_eq!(hcs(14),"2#4#6#8#11#14#");
}

fn hcs(n: usize) -> String {
    let mut s: Vec<usize>;
    let mut t: Vec<Vec<usize>>=vec![];
    loop {
        s=vec![];
        let mut l: usize=0;
        if t.len() > 0 {
            s=t.pop().unwrap();
            l=s.iter()
                .map(|i| if *i==1 {0} else {format!("{}",i).len()}+1)
                .sum();
        }
        if l==n {
            break;
        }
        if l>n {
            continue;
        }
        let mut c=l;
        loop {
            let tt=if c==1 {0} else {format!("{}",c).len()} + l + 1;
            if c==tt {
                let mut k=s.clone();
                k.push(c);
                t.push(k);
            }
            if c > tt {
                break;
            }
            c+=1;
        }
    }
    let mut out: String="".to_string();
    for i in s {
        if i!=1 {
            out.push_str(&format!("{}",i));
        }
        out.push('#');
    }
    return out;
}
