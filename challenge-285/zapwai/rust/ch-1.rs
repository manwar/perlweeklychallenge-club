fn main() {
    let routes = vec![vec!['B','C'], vec!['D','B'], vec!['C','A']];
    proc(routes);
    let routes2 = vec![vec!['A','Z']];
    proc(routes2);
}

fn proc(routes :Vec<Vec<char>>) {
    println!("Input: ");
    for j in 0 .. routes.len() {
	println!("{:?}", routes[j]);
    }
    let mut inlist :Vec<char> = Vec::new();
    let mut out :Vec<char> = Vec::new();
    for j in routes {
	inlist.push(j[0]);
	out.push(j[1]);
    }
    let mut ans = 'a';
    for needle in out {
	let mut found = 0;
	for hay in &inlist {
	    if needle == *hay {
		found = 1;
		break;
	    }
	}
	if found == 0 {
	    ans = needle;
	}
    }
    println!( "Output: {ans}");
}

