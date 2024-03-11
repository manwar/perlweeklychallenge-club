use std::collections::HashMap;

fn main() {
    let l1 = [1,2,2,1,1,3];
    let l2 = [1,2,3];
    let l3 = [-2,0,1,-2,1,1,0,1,-2,9];
    let lists : Vec<&[i32]> = vec![&l1, &l2, &l3];
    for l in lists {
	proc(&l);
    }
}

fn proc(l : &[i32]) {
    println!("Input: {:?}", l);
    let mut f = HashMap::new();
    for k in l {
	let entry = f.entry(k).or_insert(0);
	*entry += 1;
    }
    let mut freqs = vec![];
    let mut out = 1;
    for v in f.values() {
	if freqs.contains(v) {
	    out = 0;
	} else {
	    freqs.push(*v);
	}
    }
    println!("Output: {out}");
}
