use std::io;
fn main() {
    println!("Please enter a value for n: ");
    let mut n = String::new();
    io::stdin()	.read_line(&mut n);
    let num = n.trim().parse::<i32>().unwrap();
    let mut cnt = 0;
    for i in 2 ..= num {
	if is_prime(i) { cnt += 1 }
    }
    println!("Input: {num}");
    println!("Output: {cnt}");
}
fn is_prime( n: i32 ) -> bool {
    for i in 2 ..= n/2 {
	if n % i == 0 { return false }
    }
    return true;
}
