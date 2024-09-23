fn main() {
    let s1 = "123";
    proc(s1);
    let s2 = "2";
    proc(s2);
    let s3 = "1400";
    proc(s3);
}

fn reverse(s : String) -> String {
    let r : Vec<char> = s.chars().collect();
    let mut ans = String::new();
    for i in 0 .. r.len() {
	ans.push_str(&r[r.len() - i - 1].to_string());
    }
    return ans;
}

fn is_pal(s : String) -> bool {
    let r = reverse(s.clone());
    return s == r;
}

fn proc(s : &str) {
    println!( "Input: {s}");
    let mut n = s.parse::<i32>().unwrap();
    let mut found = false;
    let mut step = 1;
    while !found {
	let mut m = n - step;
	if is_pal(m.to_string()) {
	    found = true;
	    n = m;
	} else {
	    m = n + step;
	    if is_pal(m.to_string()) {
		found = true;
		n = m;
	    }
	}
	step += 1;
    }
    println!( "Output: {n}");
}
