
fn A(m :i32, n :i32) -> i32 {
    if m == 0 {
	return n + 1;
    } else if n == 0 {
	return A(m - 1, 1);
    } else {
	return A(m - 1, A(m, n - 1));
    }
}

fn main() {
    println!("{}", A(1,2));
}
