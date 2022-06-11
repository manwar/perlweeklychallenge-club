#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(mindepth(str2tree("1 | 2 3 | 4 5")), 2);
}

#[test]
fn test_ex2() {
    assert_eq!(mindepth(str2tree("1 | 2 3 | 4 *  * 5 | * 6")), 3);
}

fn str2tree(st: &str) -> Vec<u32> {
    let mut o: Vec<u32> = vec![0];
    let mut d = 0;
    let mut p = 0;
    for e in st.split_whitespace() {
        if e == "|" {
            d += 1;
            p = 0;
            let m = (1 << (d + 1)) - 1;
            if o.len() < m {
                o.resize(m, 0);
            }
        } else {
            let mut y = 0;
            if e != "*" {
                y = e.parse::<u32>().unwrap();
            }
            let i = (1 << d) - 1 + p;
            o[i] = y;
            p += 1;
        }
    }
    return o;
}

fn mindepth(tree: Vec<u32>) -> usize {
    let mut firstleaf = tree.len();
    for (i, e) in tree.iter().enumerate() {
        if *e == 0 {
            continue;
        } else if (i + 1) << 1 >= tree.len() {
            firstleaf = i;
            break;
        } else {
            let ni = ((i + 1) << 1) - 1;
            if tree[ni] == 0 && tree[ni + 1] == 0 {
                firstleaf = i;
                break;
            }
        }
    }
    firstleaf += 1;
    let mut d = 0;
    while firstleaf > 0 {
        firstleaf >>= 1;
        d += 1;
    }
    return d;
}
