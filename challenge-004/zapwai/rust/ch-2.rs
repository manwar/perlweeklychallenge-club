use std::collections::HashMap;
use std::fs;

fn main() {
    let allow = "docgotrark";
    let file_path = "004-file.txt";
    let contents = fs::read_to_string(file_path)
        .expect("No file?");
    let words = contents.split("\n");    
//    let words = ["dog", "chair", "rack", "doggo"];    
    let mut f = HashMap::new();
    fill(&mut f, allow);
    println!("Input: {allow}");
    let mut ans = Vec::new();
    for word in words {
	let mut g = HashMap::new();
	fill(&mut g, word);
	if comp(&f, &g) {
	    ans.push(word);
	}
    }
    ans.pop();
    println!("Output: {:?}",ans);
}

fn fill(f :&mut HashMap<char, i32>, allow :&str) {
    for c in allow.chars() {
	f.insert(c, 0);
    }
    for c in allow.chars() {
	f.insert(c, f.get(&c).unwrap() + 1);
    }
}

fn comp(f : &HashMap<char, i32>, g : &HashMap<char, i32>) -> bool {
    for k in g.keys() {
	if !f.contains_key(k) {
	    return false;
	}
	if f.get(k) < g.get(k) {
	    return false;
	}
    }
    return true;
}
