#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sparkline(vec![0, 10]), "▁█".to_string());
}

#[test]
fn test_ex2() {
    assert_eq!(sparkline(vec![1, 2, 3, 4, 5, 6, 7, 8]), "▁▂▃▄▅▆▇█".to_string());
}

fn sparkline(nn: Vec<i32>) -> String {
    let bar = (9601..=9608)
        .map(|i| char::from_u32(i).unwrap())
        .collect::<Vec<char>>();
    let mn = *nn.iter().min().unwrap();
    let mx = *nn.iter().max().unwrap();
    let inscale = mx - mn;
    let outscale = bar.len();
    let mut o = "".to_string();
    for n in nn {
        let mut i =
            (((n - mn) * outscale as i32) as f64 / (inscale as f64)) as usize;
        if i > outscale - 1 {
            i = outscale - 1;
        }
        o.push(bar[i]);
    }
    o
}
