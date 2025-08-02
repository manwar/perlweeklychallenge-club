fn f(c :i32) -> f32 {
    let m = (212. - 32.) / 100.0; 
    return m*(c as f32) + 32.;
}

fn main() {
    for i in -100 .. 212 {
	if i as f32 == f(i) {
	    println!("{}C -> {}F", i, f(i));
	}
    }
}
