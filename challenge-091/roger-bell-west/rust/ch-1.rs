#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(cn("1122234".to_string()),"21321314".to_string());
}

#[test]
fn test_ex2() {
    assert_eq!(cn("2333445".to_string()),"12332415".to_string());
}

#[test]
fn test_ex3() {
    assert_eq!(cn("12345".to_string()),"1112131415".to_string());
}

fn cn(n: String) -> String {
    let mut out="".to_string();
    let mut ch='x';
    let mut count=0;
    for c in n.chars() {
        if c == ch {
            count += 1;
        } else {
            if count>0 {
                out.push_str(&(count.to_string()));
                out.push_str(&(ch.to_string()));
            }
            ch=c;
            count=1;
        }
    }
    if count>0 {
        out.push_str(&(count.to_string()));
        out.push_str(&(ch.to_string()));
    }
    return out;
}
