fn main() {
    let list1 = vec![2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5];
    let list2 = vec![2, 1, 4, 3, 5, 6];
    proc(list1, list2);
    let alist1 = vec![3, 3, 4, 6, 2, 4, 2, 1, 3];
    let alist2 = vec![1, 3, 2];
    proc(alist1, alist2);
    let blist1 = vec![3, 0, 5, 0, 2, 1, 4, 1, 1];
    let blist2 = vec![1, 0, 3, 2];
    proc(blist1, blist2);

}
fn proc(l1 :Vec<i32>, l2 :Vec<i32>) {
    println!("Input: \n list1 = {:?}\n list2 = {:?}", l1, l2);
    let mut tail : Vec<i32> = Vec::new();
    for item in &l1 {
	let mut elem_of_l2_flag = 0;
	for item2 in &l2 {
	    if item == item2 {
		elem_of_l2_flag = 1;
		break;
	    }
	}
	
	if elem_of_l2_flag == 0 {
	    tail.push(*item);
	}
    }
    let mut pre : Vec<i32> = Vec::new();
    for item2 in &l2 {
	for item in &l1 {
	    if item == item2 {
		pre.push(*item);
	    }
	}
    }
    tail.sort();
    let mut out = pre;
    for t in tail {
	out.push(t);
    }
    println!("Output: {:?}", out);
}
