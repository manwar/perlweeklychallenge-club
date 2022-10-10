#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        sequencenumber(vec!["ab1234", "cd5678", "ef1342"]),
        vec!["001234", "015678", "021342"]
    );
}

#[test]
fn test_ex2() {
    assert_eq!(
        sequencenumber(vec!["pq1122", "rs3334"]),
        vec!["001122", "013334"]
    );
}

fn sequencenumber(list: Vec<&str>) -> Vec<String> {
    let mut nn = 0;
    let mut out: Vec<String> = Vec::new();
    for ins in list {
        let mut outs = format!("{:02}", nn);
        outs.push_str(&ins[2..=5]);
        out.push(outs);
        nn += 1;
    }
    out
}
