#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::collections::HashMap;

#[test]
fn test_ex1() {
    assert_eq!(exactchange(vec![5, 5, 5, 10, 20]), true);
}

#[test]
fn test_ex2() {
    assert_eq!(exactchange(vec![5, 5, 10, 10, 20]), false);
}

#[test]
fn test_ex3() {
    assert_eq!(exactchange(vec![5, 5, 5, 20]), true);
}

#[derive(Debug)]
pub struct Reserve {
    values: Vec<u32>,
    counts: Vec<u32>,
    vm: HashMap<u32, usize>,
}

impl Reserve {
    pub fn new(vv: Vec<u32>) -> Reserve {
        let mut vq = vv.clone();
        vq.sort();
        vq.reverse();
        let mut vm: HashMap<u32, usize> = HashMap::new();
        for (i, v) in vq.iter().enumerate() {
            vm.insert(*v, i);
        }
        Reserve { values: vq, counts: vec![0; vv.len()], vm }
    }

    pub fn makechange(&mut self, price: u32, tendered: Vec<u32>) -> bool {
        let mut val: u32 = 0;
        for note in tendered {
            if !self.vm.contains_key(&note) {
                return false;
            }
            self.counts[*self.vm.get(&note).unwrap()] += 1;
            val += note;
        }
        if val < price {
            return false;
        }
        val -= price;
        for bid in 0..self.values.len() {
            while val >= self.values[bid] && self.counts[bid] > 0 {
                val -= self.values[bid];
                self.counts[bid] -= 1;
            }
        }
        val == 0
    }
}

fn exactchange(a: Vec<u32>) -> bool {
    let mut reserve = Reserve::new(vec![5, 10, 20]);
    for tendered in a {
        if !reserve.makechange(5, vec![tendered]) {
            return false;
        }
    }
    true
}
