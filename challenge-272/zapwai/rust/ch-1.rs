fn main() {
    let ip = "1.1.1.1";
    proc(ip);
    let ip2 = "255.101.1.0";
    proc(ip2);
}

fn proc(ip : &str) {
    let nums : Vec<&str> = ip.split(".").collect();
    let mut pie : String = String::new();
    for p in &nums {
	pie += p;
	pie += "[.]";
    }
    let out = &pie[..pie.len()-3];
    println!( "Input: {ip}");
    println!( "Output: {out}");
}
