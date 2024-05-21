#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::VecDeque;

#[test]
fn test_ex1() {
    assert_eq!(equalizearray(vec![4, 1], 3, 2), 9);
}

#[test]
fn test_ex2() {
    assert_eq!(equalizearray(vec![2, 3, 3, 3, 5], 2, 1), 6);
}

struct Op {
    a: Vec<u8>,
    cost: u32,
}

fn equalizearray(a0: Vec<u8>, x: u32, y: u32) -> u32 {
    let mut a = a0.clone();
    a.sort();
    let limit = *a.last().unwrap();
    let mut queue: VecDeque<Op> = VecDeque::new();
    queue.push_back(Op { a, cost: 0 });
    let mut mc = None;
    while let Some(op) = queue.pop_front() {
        if mc.is_none() || mc.expect("") > op.cost {
            if op.a[0] == *op.a.last().unwrap() {
                mc = Some(op.cost);
            } else {
                let mut p = op.a.clone();
                p[0] += 1;
                if p[0] <= limit {
                    p.sort();
                    queue.push_back(Op { a: p, cost: op.cost + x });
                    let mut q = op.a.clone();
                    q[0] += 1;
                    q[1] += 1;
                    if q[1] <= limit {
                        q.sort();
                        queue.push_back(Op { a: q, cost: op.cost + y });
                    }
                }
            }
        }
    }
    mc.unwrap()
}
