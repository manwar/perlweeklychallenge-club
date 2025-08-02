fn proc(n : i32, matrix : Vec<Vec<i32>>) {
    let mut fail :bool = false;
    println!("Input: matrix = ");
    for i in 0 .. n {
	print!("\t");
	for j in 0 .. n {
	    let i_ = i as usize;
	    let j_ = j as usize;
	    print!("{} ", matrix[i_][j_]);
	    if (i == j) || (i == n - j - 1) {
		if matrix[i_][j_] == 0 {
		    fail = true;
		}
	    } else {
		if matrix[i_][j_] != 0 {
		    fail = true;
		}
	    }
	}
	println!();
    }
    let mut output : &str;
    if !fail {
	output = "True";
    } else {
	output = "False";
    }
    println!("Output: {}", output);
}

fn main() {
    let matrix = vec![
	vec![1, 0, 0, 2],
	vec![0, 3, 4, 0],
	vec![0, 5, 6, 0],
	vec![7, 0, 0, 1],
    ];
    proc(4, matrix);

    let matrix2 = vec![ vec![1, 2, 3],
		     vec![4, 5, 6],
		     vec![7, 8, 9],
    ];
    proc(3, matrix2);

    let matrix3 = vec![ vec![1, 0, 2],
		     vec![0, 3, 0],
		     vec![4, 0, 5],
    ];
    proc(3, matrix3);
}

