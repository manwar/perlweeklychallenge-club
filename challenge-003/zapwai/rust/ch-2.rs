use std::env;
const N : usize = 100;
fn display(m : [[i32; N]; N], size: usize) {
    for i in 0 .. size {
	for _sp in 0 .. size - i {
	    print!(" ");
	}
	for j in 0 ..= i {
	    print!("{} ", m[i][j]);
	}
	println!("");
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        println!("Usage: {} <N>", args[0]);
        return;
    }
    let size :usize = match args[1].parse() {
	Ok(num) => num,
	Err(_) => {
	    println!("Please provide valid N.");
	    return;
	}
    };
    let mut m = [[0; N];N];
    m[0][0] = 1;
    m[1][0] = 1;
    m[1][1] = 1;
    for i in 0 .. size {
	for j in 0 ..= i {
	    if (j == 0) || (j == i) {
		m[i][j] = 1;
	    }
	    else {
		m[i][j] = m[i-1][j-1] + m[i-1][j];
	    }
	}
    }
    display(m, size);
}
