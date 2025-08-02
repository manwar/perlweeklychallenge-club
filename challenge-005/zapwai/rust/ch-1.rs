use std::fs::File;
use std::io::{BufRead, BufReader};

fn main() -> std::io::Result<()> {
    let args : Vec<_> = std::env::args().collect();
    if args.len() != 2 {
	println!("Usage: {} <word>", args[0]);
	println!("Output: Anagrams!");
	return Ok(());
    }

    let filename = "/usr/share/dict/words";
    let dict = read_dictionary(filename)?;
    
    let mut alph = dict.clone();
    alphabetize(&mut alph);

    let sorted_word = sort_chars(&args[1]);

    for i in 0 .. alph.len() {
	if alph[i] == sorted_word {
	    println!("{}", dict[i]);
	}
    }
    
    Ok(())
}

fn alphabetize(list : &mut Vec<String>) {
    for l in list.iter_mut() {
	let mut alpha : Vec<char> = l.chars().collect();
	alpha.sort();
	*l = alpha.into_iter().collect();
    }
}

fn read_dictionary(filename :&str) -> std::io::Result<Vec<String>> {
    let file = File::open(filename)?;
    let reader = BufReader::new(file);
    let mut dict = Vec::new();
    for word in reader.lines() {
	let word = word?.trim().to_lowercase();
	dict.push(word);
    }
    Ok(dict)
}

fn sort_chars(word: &str) -> String {
    let mut thing : Vec<char> = word.chars().collect();
    thing.sort();
    let sorted_word : String = thing.into_iter().collect();
    return sorted_word;
}
