fn main() {
    let a = vec![7, 8, 3, 12, 10];
    let o: Vec<i32> = doit(&a);
    assert_eq!(o, vec![0, 7, 0, 3, 3]);

    let a = vec![4, 6, 5];
    let o: Vec<i32> = doit(&a);
    assert_eq!(o, vec![0, 4, 4]);
}

fn doit(a: &Vec<i32>) -> Vec<i32> {
    let mut min = i32::max_value();
    a.iter().map(|next| {
        let result = if min < *next { min } else { 0 };
        min = min.min(*next);
        result
    }).collect()
}
