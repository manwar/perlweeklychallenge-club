#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(
        disarium(19),
        vec![
            0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 89, 135, 175, 518, 598, 1306, 1676,
            2427, 2646798
        ]
    );
}

fn disarium(ct: usize) -> Vec<u128> {
    let mut o: Vec<u128> = Vec::new();
    let mut pows: Vec<Vec<u128>> = Vec::new();
    pows.push(vec![1;10]);
    let mut c: u128 = 0;
    loop {
        let mut disar = 0u128;
        if c > 0 {
            let mut ca = c;
            let mut cl: Vec<usize> = Vec::new();
            let mut tx = 0;
            while ca > 0 {
                tx += 1;
                cl.push((ca % 10) as usize);
                ca /= 10;
            }
            cl.reverse();
            if tx >= pows.len() {
                for power in pows.len()..=tx {
                    let mut row: Vec<u128> = Vec::new();
                    for digit in 0..=9 {
                        row.push(pows[power-1][digit as usize] * digit);
                    }
                    pows.push(row);
                }
            }
            for (i,e) in cl.iter().enumerate() {
                disar += pows[i+1][*e];
            }
        }
        if disar == c {
            o.push(c);
            if o.len() >= ct {
                break;
            }
        }
        c += 1;
    }
    o
}
