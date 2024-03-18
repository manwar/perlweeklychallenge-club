fn main() { perfects(); }

fn perfects() {
    for p in 2 .. 15 {
	let num = 2_i32.pow(p-1) * (2_i32.pow(p) - 1);
	if is_perfect(num) { print!("{} ", num); }
    }
    println!();
}

fn is_perfect(n :i32) -> bool {
    let mut divs = vec![];
    for i in 1 .. 1 + n/2  as i32 {if n % i == 0 { divs.push(i); }}
    return n == divs.into_iter().sum();
}

