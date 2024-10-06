use rand::Rng;

fn main() {
    let s = "This supposed Cambridge research is unfortunately an urban legend";
    proc(s);
}

fn jumble(word : &str) -> String {
    let mut rng = rand::thread_rng();
    if word.len() < 4 {
	return word.to_string();
    }
    let mut Let :Vec<char> = word.chars().collect();
    let start = Let.remove(0);
    let end = Let.pop().unwrap();
    let mut order : Vec<usize> = Vec::new();
    while order.len() < Let.len() {
	let x : usize = rng.gen_range(0 .. Let.len());
	if !order.contains(&x) {
	    order.push(x);
	}
    }
    let mut middle = String::new();
    for o in order {
	middle.push(Let[o]);
    }
    format!("{}{}{}", start, middle, end)
}

fn proc(s : &str) {
    println!( "Input: {s}");
    let words :Vec<&str> = s.split(" ").collect();
    let mut ans : Vec<String> = Vec::new();
    for w in words {
	ans.push(jumble(w));
    }
    println!( "Output: {}", ans.join(" "));
}
