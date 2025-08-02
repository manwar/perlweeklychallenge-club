fn main() {
    let mystr = "p|*e*rl|w**e|*ekly|";
    proc(mystr);
    let mystr2 = "perl";
    proc(mystr2);
    let mystr3 = "th|ewe|e**|k|l***ych|alleng|e";
    proc(mystr3);
}

fn proc(mystr : &str) {
    println!("Input: {mystr}");
    let mut cnt = 0;
    let words : Vec<&str>= mystr.split('|').collect();
    for i in 0 .. words.len() {
	if i % 2 == 0 {
	    let letters = words[i].chars();
	    for l in letters {
		if l == '*' {
		    cnt += 1;
		}
	    }
	}
    }
    println!("Output: {cnt}");
}
