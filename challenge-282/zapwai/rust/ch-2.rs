fn main() {
    let mystr = "pPeERrLl";
    proc(mystr);
    let mystr2 = "rRr";
    proc(mystr2);
    let mystr3 = "GoO";
    proc(mystr3);
}
fn proc(mystr: &str) {
    println!( "Input: {mystr}");
    let lets :Vec<char> = mystr.to_lowercase().chars().collect();
    let mut prev = '0';
    let mut curr;
    let mut cnt = -1;
    for i in 0 .. lets.len() {
	curr = lets[i];
	if prev != curr {
	    cnt += 1
	}
	prev = curr;
    }
    println!( "Output: {cnt}");
}
