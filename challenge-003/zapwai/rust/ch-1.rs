const N :i64 = 1000;

fn mypow (b :i64, p :i64) -> i64 {
    let mut x = 1;
    for _i in 0 .. p {
	x *= b;
	if x > N { // to prevent overflow
	    return 0;
	}
    }
    return x;
}

fn main () {
    let mut v = vec![];
    for i in 0 .. 50 {
	for j in 0 .. 32 {
	    for k in 0 .. 22 {
		let x = mypow(2_i64,i) * mypow(3_i64,j) * mypow(5_i64, k);
		if x == 0 {
		    continue;
		}
		if x > N {
		    continue;
		}
		v.push(x);
	    }}}
    v.sort();
    println!("{:?}", v);
}
