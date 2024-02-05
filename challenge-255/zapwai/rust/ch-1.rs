use std::collections::HashMap;
fn main() {
    let s = "Perl";
    let t = "Preel";
    proc(s,t);
    
    let s = "Weekly";
    let t = "Weeakly";
    proc(s,t);
    
    let s = "Box";
    let t = "Boxy";
    proc(s,t);
}

fn proc(s : &str, t : &str) {
    let mut fs : HashMap<char, i32> = HashMap::new();
    let mut ft : HashMap<char, i32> = HashMap::new();    
    for c in s.chars() {
	if !fs.contains_key(&c) {
	   fs.insert(c,1);
	} else {
	   fs.insert(c, fs.get(&c).unwrap() + 1);	   
	}
    }
    for c in t.chars() {
	if !ft.contains_key(&c) {
	   ft.insert(c,1);
	} else {
	   ft.insert(c, ft.get(&c).unwrap() + 1);	   
	}
    }
    println!("Input: s = {s}, t = {t}");
    for k in ft.keys() {
	if !fs.contains_key(&k) || fs.get(&k).unwrap() < ft.get(&k).unwrap() {
	   println!("Output: {k}");
	}
    }

}