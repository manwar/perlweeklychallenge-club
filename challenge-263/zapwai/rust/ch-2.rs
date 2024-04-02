use std::collections::HashMap;

fn print_input(items1 :Vec<[i32;2]>, items2 :Vec<[i32;2]>) {
    println!("Input: items1 = {:?}, items2 = {:?}", items1, items2);
}

fn print_output(h: HashMap<i32, i32>) {
    print!("Output: ");
    for i in h.keys() {
	print!("({i}, {}) ", h.get(&i).unwrap());
    }
    println!();
}

fn proc(items1 :Vec<[i32;2]>, items2 :Vec<[i32;2]>) {
    print_input(items1.clone(), items2.clone());
    let mut h : HashMap<i32, i32> = HashMap::new();
    for block in items1 {
	let k = block[0];
	let v = block[1];
	if h.contains_key(&k) {
	    let current_value = h.get(&k).unwrap();
	    h.insert(k, current_value + v);
	} else {
	    h.insert(k, v);
	}
    }
    for block in items2 {
	let k = block[0];
	let v = block[1];
	if h.contains_key(&k) {
	    let current_value = h.get(&k).unwrap();
	    h.insert(k, current_value + v);
	} else {
	    h.insert(k, v);
	}
    }
    print_output(h);
}

fn main() {
    let items1c = vec![ [1,1], [2,1], [3,2] ];
    let items2c = vec![ [2,2], [1,3] ];
    let items1a = vec![ [1,2], [2,3], [1,3], [3,2] ];
    let items2a = vec![ [3,1], [1,3] ];
    let items1b = vec![ [1,1], [2,2], [3,3] ];
    let items2b = vec![ [2,3], [2,4] ];
    proc(items1c, items2c);
    proc(items1a, items2a);
    proc(items1b, items2b);
}
