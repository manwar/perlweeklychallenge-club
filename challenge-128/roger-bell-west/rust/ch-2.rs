#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::BTreeMap;

#[test]
fn test_ex1() {
    assert_eq!(mp(vec!["11:20","14:30"],vec!["11:50","15:00"]),1);
}

#[test]
fn test_ex2() {
    assert_eq!(mp(vec!["10:20","11:00","11:10","12:20","16:20","19:00"],vec!["10:30","13:20","12:40","12:50","20:20","21:20"]),3);
}

fn mp(aa: Vec<&str>, da: Vec<&str>) -> i64 {
    let mut e: BTreeMap<i64,i64>=BTreeMap::new();
    for p in vec![(aa,1),(da,-1)] {
        for tm in p.0 {
            let hm: Vec<&str>=tm.split(':').collect();
            let ts=(hm[0].parse::<i64>().unwrap())*60+hm[1].parse::<i64>().unwrap();
            let en=e.entry(ts).or_insert(0);
            *en += p.1;
        }
    }
    let mut pt=0;
    let mut pm=0;
    for ts in e.keys() {
        pt += e.get(ts).unwrap();
        if pt > pm {
            pm=pt;
        }
    }
    return pm;
}
