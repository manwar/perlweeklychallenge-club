use std::collections::HashSet;
use itertools::Itertools;

#[test]
fn test_ex1() {
    assert_eq!(threedigitseven(vec![2, 1, 3, 0]), vec![102, 120, 130, 132, 210, 230, 302, 310, 312, 320]);
}

#[test]
fn test_ex2() {
    assert_eq!(threedigitseven(vec![2, 2, 8, 8, 2]), vec![222, 228, 282, 288, 822, 828, 882]);
}

fn concatenate(a: &Vec<u32>) -> u32 {
    let ax = a.iter().map(|x| x.to_string()).collect::<Vec<_>>();
    ax.join("").parse::<u32>().unwrap()
}

fn threedigitseven(a: Vec<u32>) -> Vec<u32> {
    let mut s: HashSet<u32> = HashSet::new();
    for d in 1 ..= 3 {
        for px in a.iter().permutations(d) {
            let py = px.iter().copied().copied().collect::<Vec<u32>>();
            let c = concatenate(&py);
            if c >= 100 && c <= 999 && c % 2 == 0 {
                s.insert(c);
            }
        }
    }
    let mut out = s.iter().copied().collect::<Vec<_>>();
    out.sort();
    out
}
