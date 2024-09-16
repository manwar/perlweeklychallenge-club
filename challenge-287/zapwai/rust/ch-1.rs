fn has_lower(mystr : &str) -> bool {
    for c in mystr.chars() {
	if c.is_lowercase() {
	    return true;
	}
    }
    return false;
}

fn has_upper(mystr : &str) -> bool {
    for c in mystr.chars() {
	if c.is_uppercase() {
	    return true;
	}
    }
    return false;
}

fn has_digit(mystr : &str) -> bool {
    for c in mystr.chars() {
	if c.is_digit(10) {
	    return true;
	}
    }
    return false;
}

fn proc(mystr : &str) {
    println!( "Input: {mystr}");
    let len = mystr.len();
    let mut len_diff = 0;
    if len < 6 {
	len_diff = 6 - len;
    } else if len > 20 {
	len_diff = len - 20;
    }

    let l : Vec<&str> = mystr.split("").collect();
    let mut lengths : Vec<i32> = Vec::new();
    let mut hits = 0;
    for i in 0 .. mystr.len() {
	if l[i] == l[i+1] {
	    hits += 1;
	} else {
	    if hits > 1 {
		lengths.push(1+hits);
	    }
	    hits = 0;
	}
    }
    if hits > 1 {
	lengths.push(1+hits);
    }
    let mut steps = 0;
    for l in lengths {
	steps += l/3;
    }

    let mut lflag = 1;
    let mut uflag = 1;
    let mut dflag = 1;
    if has_lower(mystr) {lflag = 0;}
    if has_upper(mystr) {uflag = 0;}
    if has_digit(mystr) {dflag = 0;}
    let tally = lflag + uflag + dflag;

    let mut out_val = len_diff as i32 + steps;
    if out_val < tally {
	out_val += tally - out_val;
    }
    println!( "Output: {}", out_val);
}

fn main() {
    let mut mystr = "a";
    proc(mystr);
    mystr = "aB2";
    proc(mystr);
    mystr = "PaaSW0rd";
    proc(mystr);
    mystr = "turbbbbot";
    proc(mystr);
    mystr  = "111";
    proc(mystr);

}
