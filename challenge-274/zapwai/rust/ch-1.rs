fn main() {
    let sent = "I love Perl";
    proc(sent);
    let sent2 = "Perl and Raku are friends";
    proc(sent2);
    let sent3 = "The Weekly Challenge";
    proc(sent3);
}

fn proc(sent : &str) {
    println!("Input: {sent}");
    print!("Output: ");
    let words : Vec<&str> = sent.split(" ").collect();
    for i in 0 .. words.len() {
	let lets : Vec<char> = words[i].chars().collect();
	let first_let = lets[0];
	let reword = &words[i][1..];
	let mut A = "".to_string();
	for _j in 0 .. i+1 {
	    A.push_str("a");
	}
	if is_vowel(first_let) {
	    print!("{}ma{A} ", words[i]);
	} else {
	    print!("{reword}{first_let}ma{A} ");
	}
    }
    print!("\n");
}

fn is_vowel(c : char) -> bool {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'
	|| c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U';
}
