#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::VecDeque;

#[test]
fn test_ex1() {
    assert_eq!(travelexpenditure(vec![2, 7, 25], vec![1, 5, 6, 7, 9, 15]), 11);
}

#[test]
fn test_ex2() {
    assert_eq!(
        travelexpenditure(
            vec![2, 7, 25],
            vec![1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31]
        ),
        20
    );
}

struct Costy {
    costdone: u32,
    daystodo: Vec<u32>,
}

fn travelexpenditure(costs: Vec<u32>, days0: Vec<u32>) -> u32 {
    let mut days = days0;
    days.sort();
    let validities = vec![1, 7, 30];
    let mut stack = VecDeque::new();
    stack.push_back(Costy { costdone: 0, daystodo: days.clone() });
    let mut cheapest = (days.len() as u32) * costs[0];
    while stack.len() > 0 {
        let c = stack.pop_front().unwrap();
        if c.daystodo.len() == 0 {
            if c.costdone < cheapest {
                cheapest = c.costdone;
            }
        } else {
            if c.costdone >= cheapest {
                continue;
            }
            let start = c.daystodo[0];
            for i in 0..=2 {
                let end = start + validities[i] - 1;
                let dtd = c
                    .daystodo
                    .iter()
                    .filter(|x| **x > end)
                    .map(|i| *i)
                    .collect::<Vec<u32>>();
                stack.push_back(Costy {
                    costdone: c.costdone + costs[i],
                    daystodo: dtd,
                });
            }
        }
    }
    cheapest
}
