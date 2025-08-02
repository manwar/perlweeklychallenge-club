fn main() {
    let list = [1,2,3,4,9,10,14,15,16,20];
    condense_list(&list);
}

fn condense_list(list : &[i32]) {
    println!("Input: list = {:?}", list);
    print!("Output: ");    
    let mut init_flag = false;
    let mut cont_flag = false;
    for i in 0 .. list.len()-1 {
	let diff = list[i + 1] - list[i];
	if init_flag && cont_flag {
	    if diff != 1 {
		init_flag = false;
		cont_flag = false;
		print!("-");
		print!("{}", list[i]);
	    }
	} else if init_flag {
	    if diff == 1 {cont_flag = true;}
	    else {
		init_flag = false;
		print!(",");
		print!("{}", list[i]);
	    }
	} else {
	    if i != 0 {print!(",");}
	    print!("{}", list[i]);
	    if diff == 1 {init_flag = true;}
	}
    }
    if init_flag && cont_flag {print!("-{}", list[list.len() - 1]);}
    else {print!(",{}", list[list.len() - 1]);}
    println!();
}

