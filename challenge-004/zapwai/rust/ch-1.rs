use std::process::Command;
use std::io::prelude::*;
use std::fs::File;
use std::io::SeekFrom;
fn main(){
    Command::new("curl").arg("-s").arg("http://www.geom.uiuc.edu/~huberty/math5337/groupe/digits.html").arg("-o").arg("pi.txt").output().expect("no curl");
    let mut file = File::open("pi.txt").expect("no pi");
    file.seek(SeekFrom::Start(326)).unwrap();
    let mut buffer = [0;590];
    file.read_exact(&mut buffer).unwrap();
    let string_buffer = String::from_utf8_lossy(&buffer);
    for c in string_buffer.split("") {
	if c != "\n" {
	    print!("{}", c);
	}
    }
}
