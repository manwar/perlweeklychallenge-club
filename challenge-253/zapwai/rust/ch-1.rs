fn main () {
    // let words = ["$perl$$", "$$raku$"];
    // let sep = '$';
    
    let words = ["one.two.three","four.five","six"];
    let sep = '.';

    println!("Input: sep = '{sep}' words = {:?}", words);
    print!("Output: ");
    for w in words {
	for c in w.chars() {
	   if c == sep {
		print!(" ");
	   } else {
		print!("{c}");
	   }
	}
	print!(" ");
    }
    println!("");
}