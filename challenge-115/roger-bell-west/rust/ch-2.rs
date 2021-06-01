#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sc(vec![1,0,2,6]),6210);
}

#[test]
fn test_ex2() {
    assert_eq!(sc(vec![1,4,2,8]),8412);
}

#[test]
fn test_ex3() {
    assert_eq!(sc(vec![4,1,7,6]),7614);
}

#[test]
fn test_ex4() {
    assert_eq!(sc(vec![1,3,5,7]),0);
}

fn sc (n: Vec<u32>) -> u32 {
    let mut o=n.clone();
    o.sort();
    let mut ov=o.clone().into_iter();
    let m=ov.position(|x| x % 2 == 0);
    let i: usize;
    match m {
        None => return 0,
        Some(x) => i=x,
    }
    println!("{:?}",i);
    let mut ox: Vec<u32>=vec![o[i]];
    if i>0 {
        ox.append(&mut o[0..i].to_vec());
    }
    if i+1<o.len() {
        ox.append(&mut o[i+1..o.len()].to_vec());
    }
    ox.reverse();
    return ox.into_iter().map(|i| i.to_string()).collect::<Vec<String>>().join("").parse::<u32>().unwrap();
}
