fn main() {
    let mut list = vec![1,5,1,1,6,4];
    // let mut list = vec![1,3,2,2,3,1];    
    println!("Input: {:?}",list);
    let mut cnt = 1;    
    while  cnt != 0 {
	cnt = 0;
	for i in 0..list.len()-1 {
	    if i % 2 == 0 {
		if list[i+1] < list[i] {
		    cnt += 1;
		    let hold = list[i];
		    list[i] = list[i+1];
		    list[i+1] = hold;		    
		}
	    }
	    else {
		if list[i+1] > list[i] {
		    cnt += 1;
		    let hold = list[i];
		    list[i] = list[i+1];
		    list[i+1] = hold;		    
		}		
	    }
	}
    }
    println!("Output: {:?}",list);
}
