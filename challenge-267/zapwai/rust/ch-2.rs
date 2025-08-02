fn proc(stringy : &str, widths : Vec<i32>) {
    let alph = "abcdefghijklmnopqrstuvwxyz";
    println!("Input: string = {stringy}");
    let pixwidth = 100;
    let mut width = pixwidth;
    let mut lines = 1;
    for s in stringy.chars() {
	let w = widths[alph.chars().position(|c| c == s).unwrap()];
	if width - w < 0 {
	    lines += 1;
	    width = pixwidth;
	}
	width -= w;
    }
    println!("Output: {}, {}", lines, pixwidth - width);
}

fn main() {
    let stringy = "abcdefghijklmnopqrstuvwxyz";
    let widths = vec![10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10];
    proc(stringy, widths);
    let stringy2 = "bbbcccdddaaa";
    let widths2 = vec![4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10];
    proc(stringy2, widths2);
}
