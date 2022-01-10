#! /bin/sh
//usr/bin/env rustc $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

use std::collections::HashMap;

fn pentagon(n: usize) -> usize {
    n * (3 * n - 1) / 2
}

fn pentpair() {
    let mut fpent: Vec<usize> = vec![0];
    let mut rpent: HashMap<usize, usize> = HashMap::new();
    let mut mx = 0;
    let mut a = 1;
    loop {
        while mx < a {
            mx += 1;
            fpent.push(pentagon(mx));
            rpent.insert(fpent[mx], mx);
        }
        for b in 1..=a - 1 {
            let d = fpent[a] - fpent[b];
            if rpent.contains_key(&d) {
                let s = fpent[a] + fpent[b];
                while s > fpent[mx] {
                    mx += 1;
                    fpent.push(pentagon(mx));
                    rpent.insert(fpent[mx], mx);
                }
                if rpent.contains_key(&s) {
                    println!(
                        "P({}) + P({}) = {} + {} = {} = P({})",
                        a,
                        b,
                        fpent[a],
                        fpent[b],
                        s,
                        rpent.get(&s).unwrap()
                    );
                    println!(
                        "P({}) - P({}) = {} - {} = {} = P({})",
                        a,
                        b,
                        fpent[a],
                        fpent[b],
                        d,
                        rpent.get(&d).unwrap()
                    );
                    std::process::exit(0);
                }
            }
        }
        a += 1;
    }
}

fn main() {
    pentpair();
}
