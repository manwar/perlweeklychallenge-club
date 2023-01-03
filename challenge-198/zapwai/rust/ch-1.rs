fn main() {
    // let mut list = [1,5,1,1,6,4];
    let mut list = vec![1,3,2,2,3,1];    
    println!("Input: {:?}",list);
    list.sort();
    let mut gap = 0;
    for i in 1 .. list.len()-1 {
	let diff = list[i+1] - list[i];
	if gap < diff {
	    gap = diff;
	}
    }
    println!("The sorted list is {:?}",list);
    print!("Which contains: ");
    for i in 1 .. list.len()-1 {
	let diff = list[i+1] - list[i];
	if diff == gap {
	    print!("({},{}) ",list[i],list[i+1]);
	}
    }
    println!("");

}
