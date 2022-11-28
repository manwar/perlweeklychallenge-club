#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(oddstring(vec!["adc", "wzy", "abc"]), "abc");
}

#[test]
fn test_ex2() {
    assert_eq!(oddstring(vec!["aaa", "bob", "ccc", "ddd"]), "bob");
}

fn oddstring(ss: Vec<&str>) -> String {
   for i in 0..=ss[0].len()-2 {
        let mut tab: HashMap<usize, Vec<&str>> = HashMap::new();
       for s in &ss {
           let v = (s.chars().nth(i+1).unwrap() as usize) - (s.chars().nth(i).unwrap() as usize);
           let l = tab.entry(v).or_insert(Vec::new());
           l.push(s);
       }
       for j in tab.values() {
           if j.len() == 1 {
               return j[0].to_string();
           }
       }
    }
    "".to_string()
}
