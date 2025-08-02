const ALPH : &str = "0123456789abcdefghijklmnopqrstuvwxy";

fn to35 (x : i32) -> String {
    let mut s = String::new();
    let mut q = x;
    while q > 0 {
	let r = q % 35;
	let new_char = ALPH.chars().nth(r as usize).unwrap();
	s.insert(0, new_char);
	q /= 35;
    }
    s
}

fn to10 (s : &str) -> i32 {
    let mut sum :i32 = 0;
    let mut n = s.len() as u32 - 1;
    for c in s.chars() {
	let ind = ALPH.find(c).unwrap();
	sum += ind as i32 * 35_i32.pow(n);
	if n > 0 { n -= 1; }	// bug causing overflow going from 0 to -1
    }
    sum
}

fn main() {
    let x = 100;
    println!("Input: (base-10) {x}");
    println!("Output: {}", to35(x));
    let s = "2u";
    println!("Input: (base-35) {s}");
    println!("Output: {}", to10(s));
}
