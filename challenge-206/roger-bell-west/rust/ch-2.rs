use itertools::Itertools;
use std::cmp::min;
use std::collections::HashSet;

#[test]
fn test_ex1() {
    assert_eq!(arraypairing(vec![1, 2, 3, 4]), 4);
}

#[test]
fn test_ex2() {
    assert_eq!(arraypairing(vec![0, 2, 1, 3]), 2);
}

fn arraypairing(n: Vec<usize>) -> usize {
    let nl = n.len();
    if nl % 2 == 1 {
        return 0;
    }
    let hl = nl / 2;
    let mut out = Vec::new();
    for px in (0..nl).combinations(hl) {
        let pa = px.iter().map(|i| n[*i]).collect::<Vec<usize>>();
        let ps: HashSet<usize> = HashSet::from_iter(px.into_iter());
        let pb = (0..nl)
            .filter(|i| !ps.contains(i))
            .map(|i| n[i])
            .collect::<Vec<usize>>();
        for pp in pa.iter().permutations(hl) {
            let mut s = 0;
            for i in 0..hl {
                s += min(pp[i], &pb[i]);
            }
            out.push(s)
        }
    }
    *out.iter().max().unwrap()
}
