use regex::Regex;

fn main() {
    let mut mystr = "1";
    proc(mystr);
    mystr = "56e10";
    proc(mystr);
    mystr = "2E32";
    proc(mystr);
    mystr = "a";
    proc(mystr);
    mystr = "1.2";
    proc(mystr);
    mystr = "1.2.6";
    proc(mystr);
    mystr = "3.142e10";
    proc(mystr);
    mystr = "3.142e42B";
    proc(mystr);
}

fn proc(mystr : &str) {
    println!( "Input: {mystr}");
    let mut output = "False";
    let p :Vec<&str> = mystr.split(".").collect();
    let dre = Regex::new(r"^\d+$").unwrap();
    let dere = Regex::new(r"^\d+e|E\d+$").unwrap();
    let deere = Regex::new(r"^\d+e\d+$|E\d+$").unwrap();
    if p.len() == 1 {
	if dre.is_match(mystr) {
	    output = "True";
	} else if dere.is_match(mystr) {
	    output = "True";
	}
    } else if p.len() == 2 {
	if dre.is_match(p[0]) && dre.is_match(p[1]) {
	    output = "True";
	} else if dre.is_match(p[0]) && deere.is_match(p[1]) {
	    output = "True";
	}
    }
    println!( "Output: {output}");
}
