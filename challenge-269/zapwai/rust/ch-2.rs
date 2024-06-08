fn main() {
    let mut ints = vec![2, 1, 3, 4, 5];
    let mut ints2 = vec![3,2,4];
    let mut ints3 = vec![5, 4, 3, 8];
    proc(ints);
    proc(ints2);
    proc(ints3);
}

fn proc(mut ints : Vec<i32>) {
    println!("Input: ints = {:?}", ints);
    let mut arr1 = vec![ints[0]];
    let mut arr2 = vec![ints[1]];
    ints.reverse();
    ints.pop();
    ints.pop();
    while ints.len() > 0 {
	let x = ints.pop().unwrap();
	if arr1[arr1.len()-1] > arr2[arr2.len()-1] {
	    arr1.push(x);
	} else {
	    arr2.push(x);
	}
    } 
    println!("Output: arr1 = {:?}, arr2 = {:?}", arr1, arr2);
}
