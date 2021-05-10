#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(cp("/a/"),"/a");
}

#[test]
fn test_ex2() {
    assert_eq!(cp("/a/b//c"),"/a/b/c");
}

#[test]
fn test_ex3() {
    assert_eq!(cp("/a/b/c/../.."),"/a");
}

#[test]
fn test_ex4() {
    assert_eq!(cp("/a/./b"),"/a/b");
}

fn cp(i: &str) -> String {
    let mut p=i.split("/").filter(|x| *x != "" && *x != ".").collect::<Vec<_>>();
    let mut d=true;
    while d {
        d=false;
        for pi in 1..p.len()-1 {
            if p[pi] == ".." {
                p=[&p[0..pi-2],&p[pi+1..p.len()-1]].concat();
                d=true;
                break;
            }
        }
    }
    let mut r="/".to_string();
    r.push_str(&p.join("/"));
    return r;
}
