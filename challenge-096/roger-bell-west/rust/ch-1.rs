#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(rw("The Weekly Challenge"),"Challenge Weekly The");
}

#[test]
fn test_ex2() {
    assert_eq!(rw("    Perl and   Raku are  part of the same family  "),"family same the of part are Raku and Perl");
}

fn rw(n: &str) -> String {
    let mut nr: Vec<&str>=n.split(' ').filter(|x| x.len()>0).collect();
    nr.reverse();
    let k=nr.join(" ");
    return k;
}
