/// You are given list of integers list of size n and divisor k.
///
/// Write a script to find out count of pairs in the given list that satisfies the following
/// rules.
///    The pair (i, j) is eligible if and only if
///    a) 0 <= i < j < len(list)
///    b) list[i] + list[j] is divisible by k
///
///
/// ```
/// use q1::num_pairs;
/// let pairs = num_pairs(vec![4, 5, 1, 6], 4, 2);
/// # assert_eq!(pairs, 2);
/// let pairs = num_pairs(vec![1, 2, 3, 4], 4, 2);
/// # assert_eq!(pairs, 2);
/// let pairs = num_pairs(vec![1, 3, 4, 5], 4, 3);
/// # assert_eq!(pairs, 2);
/// let pairs = num_pairs(vec![5, 1, 2, 3], 4, 4);
/// # assert_eq!(pairs, 2);
/// let pairs = num_pairs(vec![7, 2, 4, 5], 4, 4);
/// # assert_eq!(pairs, 1);
/// ```
pub fn num_pairs(input: Vec<i32>, _n: i32, k: i32) -> i32 {
    let mods: Vec<i32> = input.iter().map(|x| x % k).collect();
    let mut count = 0_i32;
    for (i, mod_i) in mods.iter().enumerate() {
        for mod_j in mods[i + 1..].iter() {
            if mod_j + mod_i == 0 || mod_i + mod_j == k {
                count += 1
            }
        }
    }
    count
}
