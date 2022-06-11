fn main() {
    let mut fact = 1;
    let mut left_fact = 1;
    for n in 1..11 {
        println!("{}", left_fact);
        fact = fact * n;
        left_fact = left_fact + fact;
    }
}
