#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(gs("GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG".to_string()),(67,"CATTTGGGGAAAAGTAAATCTGTCTAGCTGAGGAATAGGTAAGAGTCTCTACACAACGACCAGCGGC".to_string()));
}

fn gs(bs: String) -> (i32, String) {
    let mut l: HashMap<char, char>=HashMap::new();
    l.insert('C','G');
    l.insert('A','T');
    l.insert('G','C');
    l.insert('T','A');
    let mut os=String::new();
    for i in bs.chars() {
        os.push(*l.get(&i).unwrap());
    }
    return (os.len() as i32,os);
}
