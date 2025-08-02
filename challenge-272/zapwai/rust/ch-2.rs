fn main() {
    let str = "hello";
    proc(str);
    let str2 = "perl";
    proc(str2);
    let str3 = "raku";
    proc(str3);
}

fn proc(stri : &str) {
    let mut sum = 0;
    let strin : Vec<char> = stri.chars().collect();
    let mut prev = strin[0];
    for i in 0 .. strin.len() {
	let diff = strin[i] as i32 - prev as i32;
	prev = strin[i];
	sum += diff.abs();
    }
    println!( "Input: {stri}");
    println!( "Output: {sum}");
}
