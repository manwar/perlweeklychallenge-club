#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(plan(vec![2, 4, 5]), 7);
}

#[test]
fn test_ex2() {
    assert_eq!(plan(vec![4, 2, 3, 6, 5, 3]), 13);
}

fn plan(houses: Vec<u32>) -> u32 {
    let terminal = houses.len() - 2;
    let mut b = vec![vec![0]];
    let mut reward = 0;
    while b.len() > 0 {
        let c = b.pop().unwrap();
        let c1 = c[c.len() - 1];
        if c1 >= terminal {
            let r = c.iter().map(|i| houses[*i]).sum();
            if r > reward {
                reward = r;
            }
        } else {
            for n in (c1 + 2)..=(c1 + 3) {
                if n >= houses.len() {
                    break;
                }
                let mut j = c.clone();
                j.push(n);
                b.push(j);
            }
        }
    }
    return reward;
}
