#![allow(non_snake_case)]

fn main() {
    let matrix = vec![ vec![0, 1],
		       vec![1, 0],
    ];
    proc(2, 2, matrix);
    let matrix2 = vec![ vec![0, 0, 0],
			vec![1, 0, 1],
    ];
    proc(2, 3, matrix2);
    let matrix3 = vec![ vec![0, 0],
			vec![1, 1],
			vec![0, 0],
    ];
    proc(3, 2, matrix3);
}

fn proc(M : i32, N : i32, m : Vec<Vec<i32>>) {
    println!("Input: m = {:?}", m);
    let mut cnt : Vec<i32> = Vec::new();
    for _i in 0 .. M {
	cnt.push(0);
    }

    for i in 0 .. M {
	for j in 0 .. N {
	    if m[i as usize][j as usize] == 1 {
		cnt[i as usize] += 1;
	    }
	}
    }
    
    let mut max = 0;
    let mut max_index = 0;
    for i in 0 .. cnt.len() {
	if cnt[i] > max {
	    max_index = i;
	    max = cnt[i];
	}
    }
    println!( "Output: row {} (count is {})", max_index + 1, max); 
}

