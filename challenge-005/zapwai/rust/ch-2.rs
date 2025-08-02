use std::fs::File;
use std::io::{BufRead, BufReader};

fn main() -> std::io::Result<()> {
    let filename = "/usr/share/dict/words";
    let dict = read_dictionary(filename)?;

    let mut alph = dict.clone();
    alphabetize(&mut alph);
    alph.sort();
    
    let mut flag : bool = false;
    let mut cnt : u8 = 0;
    let mut maxlen : u8 = 0;
    let mut maxword : String = String::from("");

    for i in 0..alph.len()-1 {
	if flag {
	    if alph[i] != alph[i+1] {
		flag = false;
		cnt += 1;
		if maxlen < cnt {
		    maxlen = cnt;
		    maxword = alph[i].clone();
		}
		cnt = 0;
	    }
	    cnt += 1;
	} else {
	    if alph[i] == alph[i+1] {
		flag = true;
		cnt += 1;
	    }
	}
    }

    println!("{maxlen}: {maxword}");
    
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
