fn main() {
    let list = vec![1,2,3,1,1,3];
    //    let list = vec![1,2,3];
    //    let list = vec![1,1,1,1];    
    println!("Input: list = {:?}",list);
    let mut cnt = 0;
    let mut output = String::from("");
    for i in 0 ..= list.len()-2 {
	for j in i+1 ..= list.len()-1 {
	    if list[i] == list[j] {
		cnt += 1;
		output += &format!("({},{}) ",i,j);
	    }
	}
    }
    println!("Output: {cnt}");
    println!("{output}");
}
