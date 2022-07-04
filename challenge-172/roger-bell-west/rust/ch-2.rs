#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn text_ex1() {
    assert_eq!(
        fivenumber(vec![0., 0., 1., 2., 63., 61., 27., 13.]),
        vec![0., 0.5, 7.5, 44., 63.]
    );
}

fn fivenumber(n0: Vec<f64>) -> Vec<f64> {
    let mut n = n0.clone();
    n.sort_by(|a, b| a.partial_cmp(b).unwrap());
    let nl = n.len() - 1;
    let mut o = Vec::from([n[0]]);
    for quartile in 1..=3 {
        let bx = quartile * nl;
        let base = bx / 4;
        let mut v = n[base];
        if bx % 4 != 0 {
            v = (n[base] + n[base + 1]) / 2.;
        }
        o.push(v);
    }
    o.push(*n.last().unwrap());
    o
}
