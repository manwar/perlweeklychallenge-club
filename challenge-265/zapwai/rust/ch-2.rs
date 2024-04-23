use std::collections::HashMap;

fn main() {
    let mut stringy = "aBc 11c";
    let mut strlist = vec!["accbbb", "abc", "abbc"];
    proc(stringy, strlist);

    stringy = "La1 abc";
    strlist = vec!["abcl", "baacl", "abaalc"];
    proc(stringy, strlist);

    stringy = "JB 007";
    strlist = vec!["jj", "bb", "bjb"];
    proc(stringy, strlist);
}

fn freq(stringy : &str) -> HashMap<char, i32> {
    let mut f = HashMap::new();
    for m in stringy.chars() {
	if m.is_alphabetic() {
	    let _m = m.to_ascii_lowercase();
	    if f.contains_key(&_m) {
		f.insert(_m, 1 + f.get(&_m).unwrap());
	    } else {
		f.insert(_m, 1);
	    }
	}
    }
    println!("f: {:?}", f);
    return f;
}

// Return true if g contains f
fn hash_contains(g :HashMap<char, i32>, f :HashMap<char, i32>) -> bool {
    let mut cnt = 0;
    for k in f.keys() {
	if !g.contains_key(&k) {
	    continue;
	}
	if f[k] <= g[k] {
	    cnt += 1;
	}
    }
    return cnt == f.keys().len();
}

fn proc(stringy : &str, strlist : Vec<&str>) {
    println!("Input:  string = {stringy}");
    println!("\tlist = {:?}", strlist);
    let mut ans : Vec<&str> = Vec::new();
    for s in strlist {
	if hash_contains(freq(s), freq(stringy)) {
	    ans.push(s);
	}
    }
    
    let mut min = ans[0].len();
    let mut answer = ans[0];
    for i in 0 .. ans.len() {
	if ans[i].len() < min {
	    min = ans[i].len();
	    answer = ans[i];
	}
    }
    println!("Output: {answer}");
}
