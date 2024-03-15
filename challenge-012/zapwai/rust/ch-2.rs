use regex::Regex;
fn main() {
    let inp = "/a/b/c/d
/a/b/cd
/a/b/cc
/a/b/c/d/e";
    let mut alines = inp.split('\n');
    let mut prefix = alines.next().unwrap();
    let mut cnt = 1;
    while cnt > 0 {
	cnt = 0;
	let lind = prefix.rfind('/').unwrap_or(0);
	prefix = &prefix[0..lind];
	let a = format!(r"^{}/", prefix);
	let re = Regex::new(&a).unwrap();
	let lines = inp.split('\n');
	for line in lines {
	    if !re.is_match(line) {
		cnt += 1;
	    }
	}
    }
    println!("{prefix}");
}

