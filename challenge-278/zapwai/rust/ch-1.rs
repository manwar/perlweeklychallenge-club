fn main() {
    let mystr = "and2 Raku3 cousins5 Perl1 are4";
    proc(mystr);
    let mystr2 = "guest6 Python1 most4 the3 popular5 is2 language7";
    proc(mystr2);
    let mystr3 = "Challenge3 The1 Weekly2";
    proc(mystr3);
}

fn proc(mystr : &str)  {
    println!("Input: {mystr}");
    let mut words : Vec<&str> = Vec::new();
    let mut keys : Vec<i32> = Vec::new();
    for word in mystr.split(' ').collect::<Vec<&str>>() {
	let key = &word[word.len() - 1 .. word.len()];
	let w = &word[0 .. word.len() - 1];
	words.push(w);
	keys.push(key.parse::<i32>().unwrap());
    }
    let mut cnt = 1;
    while cnt > 0 {
	cnt = 0;
	for i in 0 .. words.len() - 1 {
	    if keys[i] > keys[i + 1] {
		let keynum = keys[i];
		keys[i] = keys[i + 1];
		keys[i + 1] = keynum;
		let word = words[i];
		words[i] = words[i + 1];
		words[i + 1] = word;
		cnt += 1;
	    }
	}
    }
    println!("Output: {:?}", words);
}
