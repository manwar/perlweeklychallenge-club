#![allow(non_snake_case)]
use regex::Regex;

fn main() {
    let l1 : Vec<&str> = vec!["cold", "peer", "pour", "prince", "knife"];
    let l2 : Vec<&str> = vec!["warm", "norm", "made", "prance", "dance"];
    for i in 0 .. l1.len() {
	proc(l1[i], l2[i]);
    }
}

fn dist(word1 :String, word2 :String) -> i32 {
    let mut cnt = 0;
    for i in 0 .. word1.len() {
	if &word1[i..i+1] != &word2[i..i+1] {
	    cnt += 1;
	}
    }
    return cnt;
}

fn neighbor(word :&String, word_list :&Vec<String>) -> String {
    for w in word_list {
	if dist(w.clone(), word.clone()) == 1 {
	    return w.to_string();
	}
    }
    return String::from("NULL");
}

fn check(m :usize, n :usize, A :&Vec<Vec<String>>, B :&Vec<Vec<String>>) -> Vec<String> {
    let mut ans : Vec<String> = Vec::new();
    for i in 0 ..= m {
	for j in 0 ..= n {
	    let a = intersection(&A[i], &B[j]);
	    if a.len() > 0 {
		for item in a {
		    ans.push(item);
		}
	    }
	}
    }
    return ans;
}

fn intersection(A :&Vec<String>, B :&Vec<String>) -> Vec<String> {
    let mut list :Vec<String> = vec![];
    for i in 0 .. A.len() {
	for j in 0 .. B.len() {
	    if A[i] == B[j] {
		list.push(A[i].clone());
	    }
	}
    }
    return list;
}

fn read_file(filename :&str) -> Vec<String> {
    return std::fs::read_to_string(filename)
	.expect("No file?")
	.lines()
	.map(|s| s.to_string())
	.collect()
}


fn expand(word :&String, words :Vec<String>) -> Vec<String> {
    let mut new : Vec<String>= Vec::new();
    for i in 0 .. word.len() {
	let pre = &word[0..i];
	let post = &word[i+1..word.len()];
	let a = format!(r"^{}.{}$", pre, post);
	let re = Regex::new(&a).unwrap();
	for w in &words {
	    if re.is_match(w) {
		new.push(w.to_string());
	    }
	}
    }
    let mut anew : Vec<String> = Vec::new();
    for w in new {
	if w != *word {
	    anew.push(w);
	}
    }
    return anew;
}

fn proc(input1 :&str, input2 :&str) {
    let filename = "src/bin/words";
    let limit = 4;		// max possible chain length is  2*limit

    println!("Input: {} to {}", input1, input2);
    let lines = read_file(filename);
    let wordlen = input1.len();
    if wordlen != input2.len() {
	println!("Not the same lengths.");
	return ();
    }
    let mut cnt = 0;
    let a = format!(r"^{}$|^{}$",input1,input2);
    let re = Regex::new(&a).unwrap();
    for line in	&lines {
	if re.is_match(line) {
	    cnt += 1;
	}
    }
    if cnt < 2 {
	println!("One of these inputs is not considered a word.");
	return ();
    }
    let words :Vec<String> = lines.into_iter().filter(|word| word.len() == wordlen).collect();
    let mut A : Vec<Vec<String>> = vec![vec![input1.to_string()]];
    let mut B : Vec<Vec<String>> = vec![vec![input2.to_string()]];
    let mut center :Vec<String> = Vec::new();
    let mut lvl = 0;
    while lvl < limit && center.len() == 0 {
	let mut anew :Vec<String> = Vec::new();
	let mut bnew :Vec<String> = Vec::new();
	for wa in &A[lvl] {
	    for w in expand(wa, words.clone()).iter() {
		anew.push(w.to_string());
	    }
	}
	for wb in &B[lvl] {
	    for w in expand(wb, words.clone()).iter() {
		bnew.push(w.to_string());
	    }
	}
	
	let mut uniq_a :Vec<String> = Vec::new();
	let mut uniq_b :Vec<String> = Vec::new();

	for w in anew {
	    if !uniq_a.iter().any(|i| *i == w) {
		uniq_a.push(w);
	    }
	}
	for w in bnew {
	    if !uniq_b.iter().any(|i| *i == w) {
		uniq_b.push(w);
	    }
	}
	A.push(uniq_a);
	B.push(uniq_b);
	lvl += 1;
	center = check(lvl, lvl, &A, &B);
    }
    if lvl == limit {
	println!("Output: ()");
	return ();
    }
    let mut counter = lvl - 1;
    let mut mylist = vec![center[0].clone()];
    let mut x = neighbor(&center[0], &A[counter]);
    let mut y = neighbor(&center[0], &B[counter]);
    if y != "NULL" {
	while counter > 0 {
	    let xtarget = x.clone();
	    let ytarget = y.clone();
	    mylist.insert(0, xtarget);
	    mylist.push(ytarget);
	    counter -= 1;
	    x = neighbor(&x, &A[counter]);
	    y = neighbor(&y, &B[counter]);
	}
    }
    if x != "NULL" {
	mylist.insert(0, x);
    }
    if y != "NULL" {
	mylist.push(y);
    }
    println!("Output: {:?}", mylist);
}
