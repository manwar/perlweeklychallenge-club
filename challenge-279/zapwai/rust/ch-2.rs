fn main() {
    let str = "perl";
    proc(str);
    let str2 = "book";
    proc(str2);
    let str3 = "goodmorning";
    proc(str3);
}

fn is_vowel(c: char) -> bool {
    if c == 'a' ||
	c == 'e' ||
	c == 'i' ||
	c == 'o' ||
	c == 'u' {
	    return true;
	}
    return false;
}

fn proc(str : &str) {
    println!("Input: str = {str}");
    let mut cnt = 0;
    for c in str.chars() {
	if is_vowel(c) {
	    cnt += 1;
	}
    }
    print!("Output:");
    if cnt % 2 == 0 {
	println!(" true");
    } else {
	println!(" false");
    }
}

