use std::collections::HashMap;

fn proc(word : &str) {
    let mut h = HashMap::new();
    println!("Input: {}", word);
    let mut letters = word.chars().collect::<Vec<char>>();
    l(word.len(), &mut letters, &mut h);
    let mut sorted :Vec<String> = Vec::new();
    for k in h.keys() {
	sorted.push(k.to_string());
    }
    sorted.sort();
    println!("Output {}", 1 + seek_word(word, sorted));
}

fn l(k :usize, list : &mut Vec<char>, h : &mut HashMap<String, i32>) {
    if k == 1 {
	h.insert(list.iter().collect(), 1);
    } else {
	l(k - 1, list, h);
	for i in 0 ..= k - 2 {
	    if k % 2 == 0 {
		swap(i, k-1, list);
	    } else {
		swap(0, k-1, list);
	    }
	    l(k-1, list, h);
	}
    }
}

fn swap(i :usize, j :usize, list :&mut Vec<char>) {
    let tmp = list[i];
    list[i] = list[j];
    list[j] = tmp;
}

fn seek_word(word :&str, sorted : Vec<String>) -> usize{
    for i in 0 .. sorted.len() {
	if sorted[i] == word.to_string(){
	    return i;
	}
    }
    return 10000;
}

fn main() {
    proc("CAT");
    proc("GOGGLE");
    proc("SECRET");
}
