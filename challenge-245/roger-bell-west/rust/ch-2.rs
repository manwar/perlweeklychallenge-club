use itertools::Itertools;

#[test]
fn test_ex1() {
    assert_eq!(largestofthree(vec![8, 1, 9]), 981);
}

#[test]
fn test_ex2() {
    assert_eq!(largestofthree(vec![8, 6, 7, 1, 0]), 8760);
}

fn largestofthree(digits: Vec<i32>) -> i32 {
    let mut ordered = digits.clone();
    ordered.sort_unstable_by(|a, b| b.cmp(a));
    let mut mx = 0;
    for n in (0..ordered.len()).rev() {
        for c in ordered.iter().combinations(n + 1) {
            let mut t = 0;
            for d in c {
                t *= 10;
                t += d;
            }
            if t > mx && t % 3 == 0 {
                mx = t;
            }
        }
    }
    mx
}
