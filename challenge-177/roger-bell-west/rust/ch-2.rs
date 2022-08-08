#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        ppc(20),
        vec![
            101, 16061, 31013, 35053, 38083, 73037, 74047, 91019, 94049,
            1120211, 1150511, 1160611, 1180811, 1190911, 1250521, 1280821,
            1360631, 1390931, 1490941, 1520251
        ]
    );
}

fn isprime(candidate: usize) -> bool {
    if candidate < 2 {
        return false;
    } else if candidate == 2 {
        return true;
    } else if candidate == 3 {
        return true;
    } else if candidate % 2 == 0 {
        return false;
    } else if candidate % 3 == 0 {
        return false;
    }
    let mut anchor = 0usize;
    let limit = (candidate as f64).sqrt() as usize;
    loop {
        anchor += 6;
        for t in [anchor - 1, anchor + 1].iter() {
            if *t > limit {
                return true;
            }
            if candidate % *t == 0 {
                return false;
            }
        }
    }
}

fn ppc(ct: usize) -> Vec<usize> {
    let mut o = Vec::new();
    let mut fh = 0;
    while o.len() < ct {
        fh += 1;
        let mut t = fh;
        let mut q = false;
        while t > 0 {
            if t % 10 == 0 {
                q = true;
                break;
            }
            t /= 10;
        }
        if q {
            continue;
        }
        let sfh = fh.to_string();
        let mut sc = sfh.clone();
        sc.push('0');
        sc.push_str(&sfh.chars().rev().collect::<String>());
        let c = sc.parse::<usize>().unwrap();
        if isprime(c) {
            o.push(c);
        }
    }
    o
}
