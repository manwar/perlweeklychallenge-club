fn main() {
    let words = vec!("ab", "de", "ed", "bc");
    proc(words);
    let words2 = vec!("aa", "ba", "cd", "ed");
    proc(words2);
    let words3 = vec!("uv", "qp", "st", "vu", "mn", "pq");
    proc(words3);    
}

fn proc(words: Vec<&str>) {
    println!("Input: words = {:?}",words);
    let mut cnt = 0;
    count(&mut cnt, &words);
    println!("Output: {cnt}");    
}

fn count(cnt: &mut i32, words: &Vec<&str>) {
    let mut i = 0;
    loop {
	let mut j = i + 1;
	loop {
	    if words[i] == reverse_string(words[j]) {
		*cnt += 1;
	    }
	    j += 1;
	    if j >= words.len() { break; }
	}
	i += 1;
	if i >= words.len() - 1 { break; }
    }
}

fn reverse_string(input: &str) -> String {
    let reversed: String = input.chars().rev().collect();
    reversed
}
