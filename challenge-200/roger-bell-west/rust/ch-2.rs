#! /bin/sh
//usr/bin/env rustc $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

fn sevensegment(l: usize) {
    let disp = [0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f, 0x67];
    let mut v = Vec::new();
    if l == 0 {
        v = vec![0];
    } else {
        let mut ll = l;
        while ll > 0 {
            v.push(ll % 10);
            ll /= 10;
        }
        v.reverse();
    }
    let mut d = vec![vec![' '; 6 * v.len()]; 7];
    for (i, vv) in v.iter().enumerate() {
        let x = 6 * i;
        let da = disp[*vv];
        if da & 1 > 0 {
            for xa in x + 1..=x + 3 {
                d[0][xa] = '#';
            }
        }
        if da & 2 > 0 {
            for y in 1..=2 {
                d[y][x + 4] = '#';
            }
        }
        if da & 4 > 0 {
            for y in 4..=5 {
                d[y][x + 4] = '#';
            }
        }
        if da & 8 > 0 {
            for xa in x + 1..=x + 3 {
                d[6][xa] = '#';
            }
        }
        if da & 16 > 0 {
            for y in 4..=5 {
                d[y][x] = '#';
            }
        }
        if da & 32 > 0 {
            for y in 1..=2 {
                d[y][x] = '#';
            }
        }
        if da & 64 > 0 {
            for xa in x + 1..=x + 3 {
                d[3][xa] = '#';
            }
        }
    }
    for r in d {
        println!("{}", r.iter().collect::<String>());
    }
}

fn main() {
    sevensegment(1234567890);
    sevensegment(200);
}
