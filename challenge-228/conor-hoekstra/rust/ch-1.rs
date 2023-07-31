fn unique_sum(nums: Vec<i32>) -> i32 {
    nums.iter()
        .counts()
        .iter()
        .map(|(k, v)| if v == &1 { k } else { &0 })
        .sum()
}

// Tests
fn main() {
    println!("{}", unique_sum(vec![2, 1, 3, 2])); // 4
    println!("{}", unique_sum(vec![1, 1, 1, 1])); // 0
    println!("{}", unique_sum(vec![2, 1, 3, 4])); // 10
}
