use std::collections::HashMap;
fn main() {
    let p = "Joe hit a ball, the hit ball flew far after it was hit.";
    let w = "hit";
    proc(p,w);
    
    let p =  "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.";
    let w = "the";
    proc(p,w);
}

fn proc(p: &str, w: &str) {
    let mut pt : String = String::from("");
    for c in p.chars() {
	if c.is_alphabetic() || c.is_whitespace() {
	   let s = String::from(c);
	   pt.push_str(&s);
	}
    }
    let words = pt.split(" ");
    let mut f : HashMap<&str, i32> = HashMap::new();
    for word in words {
	if word != w {
	   if !f.contains_key(word) {
		f.insert(word, 1);
	   } else {
		f.insert(word, f.get(&word).unwrap() + 1);		
	   }
	}
    }
    //    println!("{:?}",f);
    let mut max = 0;
    let mut ans = String::new();
    for (k, v) in f {
	if max < v {
	   max = v;
	   ans = k.to_string();
	}
    }
    println!("Input: w = {w}, p = {p}");
    println!("Output: {ans}");
}