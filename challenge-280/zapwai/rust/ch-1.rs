fn main() {
    let mystr = "abcddbca";
    proc(mystr);
    let mystr2 = "abcd";
    proc(mystr2);
    let mystr3 = "abcdabbb";
    proc(mystr3);
}

fn proc(mystr : &str) {
    println!( "Input: mystr");
    let mut letter : char = '0';
    let mut gotten : Vec<char> = Vec::new();
    for l in mystr.chars() {
	for g in &gotten {
	    if l == *g {
		letter = l;
	    }
	}
	if letter != '0' {
	    break;
	} else {
	    gotten.push(l);
	}
    }
    println!( "Output: {letter}");
}
