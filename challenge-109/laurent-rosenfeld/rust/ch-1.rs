fn chowla(n : i32) -> i32 {
    let mut sum = 0;
    for i in 2..=n/2 {
        if n % i == 0 {
            sum += i
        }
    }
    return sum
}
fn main() {
    for n in 1..20 {
        print!("{}, ", chowla(n));
    }
    println!("{} ", chowla(20));
}
