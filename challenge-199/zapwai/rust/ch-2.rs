fn main() {
    let array : Vec<i32> = vec![3,0,1,1,9,7];
    let (x,y,z) : (i32, i32, i32) = (7,2,3);
    println!("Input: array = {:?}",array);
    let mut cnt = 0;
    let mut output = String::from("Good triplets are... \n");
    for i in 0 .. array.len() - 2 {
	for j in i + 1 .. array.len() - 1 {
	    for k in j + 1 .. array.len() {
		if ((array[i] - array[j]).abs() <= x) &&
		    ((array[j] - array[k]).abs() <= y) &&
		    ((array[i] - array[k]).abs() <= z) {
			cnt += 1;
			output += &format!("({},{},{}) -> (i,j,k) = ({},{},{})\n",array[i],array[j],array[k],i,j,k);
		    }
	    }
	}
    }
    println!("Output: {cnt}");
    println!("{output}");
}
