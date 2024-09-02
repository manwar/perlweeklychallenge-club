fn main() {
    let amt = 100;
    let mut cnt = 0;
    for h in 0 ..= amt/50 {
	for q in 0 ..= amt/25 {
	    for d in 0 ..= amt/10 {
		for n in 0 ..= amt/5 {
		    for p in 0 ..= amt {
			if tally(p, n, d, q, h) == amt {
			    cnt += 1;
			}
		    }
		}
	    }
	}
    }
    println!( "There are {cnt} ways to make change for {amt} cents");
}

fn tally(p: i32, n:i32, d:i32, q:i32, h:i32) -> i32 { return p + 5*n + 10*d + 25*q + 50*h; }

