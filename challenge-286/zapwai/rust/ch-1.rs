use std::fs::File;
use std::io::{self, Read};
use rand::Rng;
fn main() -> io::Result<()> {
    let mut file = File::open("ch-1.rs")?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    let words : Vec<&str> = contents.split_whitespace().collect();
    let mut rng = rand::thread_rng();
    let num = rng.gen_range(0..words.len());
    println!("{}", words[num]);
    Ok(())
}
