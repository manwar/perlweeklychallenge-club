use itertools::Itertools;

#[test]
fn test_ex1() {
    assert_eq!(grouphero(vec![2, 1, 4]), 141);
}

fn grouphero(nums0: Vec<u32>) -> u32 {
    let mut nums = nums0;
    nums.sort();
    let mut sum = 0;
    for l in 1..=nums.len() {
        for c in nums.iter().combinations(l) {
            let h = **c.last().unwrap();
            sum += h * h * c[0];
        }
    }
    sum
}
