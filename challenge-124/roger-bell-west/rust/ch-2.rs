use std::collections::HashSet;
use permutator::Combination;

fn main() {
    tow(vec![10, 20, 30, 40, 50, 60, 70, 80, 90, 100]);
    println!("");
    tow(vec![10, -15, 20, 30, -25, 0, 5, 40, -5]);
}

fn tow(n: Vec<i64>) {
    let target: i64=n.iter().sum::<i64>()/2;
    let k: usize=n.len()/2;
    let mut bestval: i64=-1;
    let mut bestset: Vec<i64>=vec![];
    n.combination(k).for_each(|set| {
        let l: i64=(target-set.iter().map(|i| **i).sum::<i64>()).abs();
        if bestval < 0 || l < bestval {
            bestval=l;
            bestset=set.iter().map(|i| **i).collect();
        }
    });
    let mut o=vec![vec![],vec![]];
    let mut r: HashSet<i64>=HashSet::new();
    for i in bestset {
        r.insert(i);
    }
    for m in n {
        if r.contains(&m) {
            o[1].push(m);
        } else {
            o[0].push(m);
        }
    }
    for i in 0..=1 {
        println!("({})",o[i].iter().map(|j| j.to_string()).collect::<Vec<String>>().join(", "));
    }
}
