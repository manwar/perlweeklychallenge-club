fn main() {
    let words1 = vec!["Perl", "is", "my", "friend"];
    let words2 = vec!["Perl", "and", "Raku", "are", "friend"];
    proc(words1, words2);
    let words3 = vec!["Perl", "and", "Python", "are", "very", "similar"];
    let words4 = vec!["Python", "is", "top", "in", "guest", "languages"];
    proc(words3, words4);
}

fn proc(words1 : Vec<&str>, words2 : Vec<&str>) {
    println!("Input: {:?}, {:?}", words1, words2);
    let mut cnt = 0;
    for word1 in &words1 {
	if is_multi(word1, &words1) {
	    continue;
	}
	for word2 in &words2 {
	    if is_multi(word2, &words2) {
		continue;
	    }
	    if word1 == word2 {
		cnt += 1;
	    }
	}
    }
    println!("Output: {cnt}");
}

fn is_multi(word : &str, words : &Vec<&str>) -> bool {
    let mut cnt = 0;
    for w in words {
	if word == *w {
	    cnt += 1;
	}
    }
    if cnt == 1 {
	return false;
    }
    return true;
}
