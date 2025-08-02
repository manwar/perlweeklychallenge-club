fn main() {
    let mystr = "challenge";
    let mychar = 'e';
    proc(mystr, mychar);
    let mystr2 = "programming";
    let mychar2 = 'a';
    proc(mystr2, mychar2);
    let mystr3 = "champion";
    let mychar3 = 'b';
    proc(mystr3, mychar3);
}
fn proc(mystr : &str, mychar : char) {
    println!( "Input: mystr = {mystr}, mychar = {mychar}") ;
    let ind = mystr.chars().position(|c| c == mychar);
    if ind != None {
	let indy = ind.unwrap();
	let begin = &mystr[0 .. indy + 1];
	let end = &mystr[indy + 1 .. ];
	print!("Output: ");
	arrange(begin);
	println!("{}", end);
    } else {
	println!( "Output: {mystr}");
    }
}
fn arrange(word : &str) {
    let mut arr : Vec<char> = word.chars().collect();
    arr.sort();
    for c in arr {
	print!("{c}");
    }
}
