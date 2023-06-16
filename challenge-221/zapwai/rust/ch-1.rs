use std::collections::HashMap;
fn main() {
    let chars = "atach".to_string();
    let words = vec!["cat", "bt", "hat", "tree"];
//    let words = vec!["hello", "world", "challenge"];
//    let chars = "welldonehopper".to_string();
    let out_chars = chars.clone();
    let freq = fill(chars);
    let mut sum : i32 = 0;
    for word in words.iter() {
	let w = fill(word.to_string());
	sum += contrib(&w, &freq);
    }
    println!("Input: chars = {}", out_chars);
    println!("       words = {:?}", words);    
    println!("Output: {sum}");
}
fn contrib(w: &HashMap<String, i32>, f: &HashMap<String, i32>) -> i32 {
    for wkey in w.keys() {
	if f.get(wkey).is_some() {
	    if f.get(wkey).unwrap() < w.get(wkey).unwrap() {
		return 0;
	    }
	}
	else {
	    return 0;
	}
    }
    let mut s = 0;
    for wval in w.values() {
	s += wval;
    }
    s
}
fn fill(word: String) -> HashMap<String, i32> {
    let mut h = HashMap::new();
    let myword = word;
    let letters = myword.split("");
    for l in letters {
	if l.is_empty() { continue; }
	let val = h.get(l);
	if val.is_some() {
	    h.insert(l.to_string(), val.unwrap() + 1);
	} else {
	    h.insert(l.to_string(), 1);
	}
    }
    h
}
