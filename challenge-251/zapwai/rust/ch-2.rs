fn main() {
    let a = [ [ 3,  7,  8],
		[ 9, 11, 13],
		[15, 16, 17] ];

    // let a = [ [ 1, 10,  4,  2],
    //             [ 9,  3,  8,  7],
    //             [15, 16, 17, 12] ];

    // let a = [ [7 ,8],
    // 	       [1 ,2] ];

    let w :usize = a[0].len();
    let h :usize = a.len();
    //     proc(w, h, a);
    // }

    // fn proc(w: usize, h: usize, a: [[i32;3];3]) {
    let mut mins = Vec::new();
    let mut maxs = Vec::new();
    
    let mut j = 0;
    while j <= h-1 {
	mins.push(a[j].iter().min().unwrap());
	j += 1;
    }
    let mut i = 0;
    while i <= w-1 {
	let mut max = -1;
	j = 0;
	while j <= h-1 {
	    let x = a[j][i];
	    if max < x {
		max = x;
	    }
	    j += 1;
	}
	maxs.push(max);
	i += 1;
    }
    
    let mut luck = -1;
    'outer:    for i in mins {
	for j in &maxs {
	    if i == j {
		luck = *j;
		break 'outer;
	    }
	}
    }
    println!("Input: ");
    for i in 0 .. h {

	println!("\t{:?}", a[i]);
    }
    println!("Output: {luck}");
}
