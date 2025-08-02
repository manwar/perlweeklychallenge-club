fn main() {
    let sentence = "Perl Weekly Challenge";
    let keys = vec!['l', 'a'];
    proc(sentence, keys);
    let sentence2 = "Perl and Raku";
    let keys2 = vec!['a'];
    proc(sentence2, keys2);
    let sentence3 = "Well done Team PWC";
    let keys3 = vec!['l', 'o'];
    proc(sentence3, keys3);
}

fn proc(sentence : &str, keys : Vec<char>) {
    println!("Input: Sentence = {sentence}, keys = {:?}", keys);
    let mut num = 0;
    for word in sentence.split(" ") {
	let mut tally = 0;
	for key in &keys {
	    if word.contains(*key) {
		break;
	    } else {
		tally += 1;
	    }
	}
	if tally == keys.len() {
	    num += 1;
	}
    }
    println!("Output: {num}");
}

