fn main() {
    let mut mystr = "aabb";
    proc(mystr);
    mystr = "abab";
    proc(mystr);
    mystr = "aaa";
    proc(mystr);
    mystr = "bbb";
    proc(mystr);
}

fn proc(mystr : &str) {
    println!("Input: mystr = {mystr}");
    let mut ver : bool = false;
    for l in mystr.chars() {
	if l == 'b' {
	    ver = true;
	}
    }
    let mut bflag : bool = false;
    if ver {
	for l in mystr.chars() {
	    if l == 'a' && bflag {
		ver = false;
		break;
	    } else {
		if l == 'b' {
		    bflag = true;
		}
	    }
	}
    }
    if ver {
	println!("Output: true");
    } else {
	println!("Output: false");
    }
}
