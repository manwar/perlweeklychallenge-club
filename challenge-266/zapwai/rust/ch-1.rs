fn main() {
    let mut line1 = "Mango is sweet";
    let mut line2 = "Mango is sour";
    proc(line1, line2);

    line1 = "Mango Mango";
    line2 = "Orange";
    proc(line1, line2);

    line1 = "Mango is Mango";
    line2 = "Orange is Orange";
    proc(line1, line2);
}

fn proc(line1 : &str, line2 : &str) {
    let mut words :Vec<&str> = Vec::new();
    for w in line1.split(" ") {
	words.push(w);
    }
    for w in line2.split(" ") {
	words.push(w);
    }
    words.sort();
    let mut match_flag = false;
    let mut ans : Vec<&str> = Vec::new();
    for i in 0 .. words.len() - 1 {
	if match_flag {
	    if words[i] != words[i+1] {
		match_flag = false;
	    }
	    continue;
	}
	if words[i] == words[i+1] {
	    match_flag = true;
	    continue;
	}
	ans.push(words[i]);
    }
    if !match_flag {
	ans.push(words.last().unwrap());
    }
    println!("Input: line1 = {line1}; line2 = {line2}");
    println!("Output: {:?}", ans);
}
