#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(cc("THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG",3),"QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD");
}

#[test]
fn test_ex2() {
    assert_eq!(cc("QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD",-3),"THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG");
}

#[test]
fn test_ex3() {
    assert_eq!(cc("A QUICK MOVEMENT OF THE ENEMY WILL JEOPARDIZE SIX GUNBOATS",13),"N DHVPX ZBIRZRAG BS GUR RARZL JVYY WRBCNEQVMR FVK THAOBNGF");
}

fn cc(s: &str, n: i8) -> String {
    let plain=(b'A'..=b'Z').map(|b| b as char).collect::<Vec<char>>();
    let mut cmap: HashMap<char,char>=HashMap::new();
    let asize=plain.len();
    for p in 0..asize {
        let c=(((p as i8)+(asize as i8)*2-n) % (asize as i8)) as usize;
        cmap.insert(plain[p],plain[c]);
    }
    let mut out: String="".to_string();
    for ss in s.chars() {
        if cmap.contains_key(&ss) {
            out.push(*cmap.get(&ss).unwrap());
        } else {
            out.push(ss);
        }
    }
    return out.to_string();
}
