fn main() {
    let words = vec!["This", "is", "a test of the", "center function"];
    center(words);
}

fn center(words : Vec<&str>) {
    let mut v = Vec::new();
    for w in &words {
	v.push(w.len());
    }
    let m = v.into_iter().max().unwrap();
    for word in words {
	for i in 0 .. (m - word.len()) {
	    if i % 2 == 0 {
		print!(" ");
	    }
	}
	println!("{}", word);
    }
}

