fn dot_product(a1: Vec<i32>, a2: Vec<i32>) -> i32 {
    let mut res = 0;
    a1.iter().enumerate().for_each(|(i, v)| {
        res += v * a2[i];
    });
    return res
}
fn main() {
    println!("{} ", dot_product(vec![1, 2, 3],vec![4, 5, 6]));
}
