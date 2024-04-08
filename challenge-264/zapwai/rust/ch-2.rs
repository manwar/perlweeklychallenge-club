fn proc(source :Vec<i32>, indices :Vec<i32>) {
    println!("Input: Source = {:?}, Indices = {:?}", source, indices);
    let mut target : Vec<i32> = Vec::new();

    for i in 0 .. source.len() {
	let chunk = &target[indices[i] as usize .. target.len()];
	let pre = &target[0 .. indices[i] as usize];
	let mut land : Vec<i32> = Vec::new();
	for p in pre {
	    land.push(*p);
	}
	land.push(source[i]);
	for c in chunk {
	    land.push(*c);
	}
	target = land;
    }
    println!("Output: {:?}", target);
}

fn main() {
    let mut source  = vec![0, 1, 2, 3, 4];
    let mut indices = vec![0, 1, 2, 2, 1];
    proc(source, indices);

    source  = vec![1, 2, 3, 4, 0];
    indices = vec![0, 1, 2, 3, 0];
    proc(source, indices);

    source = vec![1];
    indices = vec![0];
    proc(source, indices);
}
