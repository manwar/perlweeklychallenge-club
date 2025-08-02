fn main() {
    let str = String::from("PeRlwEKLy");
    println!("Input: str: {}", str);
    println!("Output: {}", proc(str));
}

fn proc(str :String) -> char {
    let letters :Vec<char> = str.chars().collect();
    let mut upper :Vec<char> = Vec::new();
    let mut lower :Vec<char> = Vec::new();
    for l in letters {
	if l.is_uppercase() {upper.push(l);}
	else {lower.push(l);}
    }
    let mut common = Vec::new();
    for u in upper {
	let g = u.to_lowercase().next().unwrap();
	for l in &lower {
	    if g == *l {
		common.push(u);
	    }
	}
    }
    common.sort();
    return *common.last().unwrap();
}
