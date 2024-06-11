fn main() {
    let mut mystr = "perl"; let mut mychar = 'e';
    proc(mystr, mychar);
    mystr = "java"; mychar = 'a';
    proc(mystr, mychar);
    mystr = "python"; mychar = 'm';
    proc(mystr, mychar);
    mystr = "ada"; mychar = 'a';
    proc(mystr, mychar);
    mystr = "ballerina"; mychar = 'l';
    proc(mystr, mychar);
    mystr = "analitik"; mychar = 'k';
    proc(mystr, mychar);    
}

fn proc(mystr : &str, mychar : char) {
    println!("Input: mystr = {mystr}, mychar = {mychar}");
    let mut cnt = 0;
    for l in mystr.chars() {
	if l == mychar {
	    cnt += 1;
	}
    }
    let i :f32 = 100.0 * cnt as f32 / mystr.len() as f32;
    println!("Output: {}", i.round());
}
