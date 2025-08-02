fn main() {
    let s = "Perl Weekly Challenge";
    let cnt = s.chars().filter(|&c| c == 'e').count();
    println!("Input: {s}");
    print!("Output: ");
    for c in s.chars() {
	if c == 'e' { print!("E"); }
	else { print!("{c}"); }
    }
    println!("\ne occurs {cnt} times in the input sentence.");
}
