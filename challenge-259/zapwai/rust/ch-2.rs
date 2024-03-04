#![allow(unused)]

const ROWS_IN_FILE :usize = 500;
const MAX_NUM_OF_FIELDS :usize = 12;
const LENGTH_OF_FIELDNAME :usize = 30;

fn read_file(filename : &str) -> Vec<String> {
    return std::fs::read_to_string(filename)
	.expect("No file?")
	.lines()
	.map(|s| s.to_string())
	.collect()
}

fn prev_space(pos :usize, line :&String) -> usize {
    let mut i = pos;
    while line.chars().nth(i).unwrap() != ' ' {
	i -= 1;
    }
    return i;
}

fn proc(line_num : usize, line : &String, field : &mut Vec<Vec<String>>, value : &mut Vec<Vec<String>>) {
    if line.chars().nth(0).unwrap() == '{' {
	let mut eq_pos :[usize;MAX_NUM_OF_FIELDS] = [0; MAX_NUM_OF_FIELDS];
	let mut j = 0;
	for i in 2 .. line.len() {
	    if line.chars().nth(i).unwrap() == '=' {
		eq_pos[j] = i;
		j += 1;
	    }
	}
	let num_of_fields = j;
	let mut id :Vec<char> = vec![];
	let mut id_flag = true;
	for i in 3 .. line.len() {
	    if id_flag && line.chars().nth(i).unwrap() == ' ' {
		continue;
	    }
	    else if id_flag {
		id.push(line.chars().nth(i).unwrap());
		id_flag = false;
	    }
	    else {
		if line.chars().nth(i).unwrap() == ' ' {
		    break;
		}
		else {
		    id.push(line.chars().nth(i).unwrap());
		}
	    }
	}
	let name = id.iter().collect::<String>();
	if name.len() > 2 && &name[0..3] == "end" {
	    return ();
	}
	println!("name => {name}");
	if name.len() > 2 && "end" == &name[0..3] { return (); }
	field.push(vec![]);
	for i in 0 .. num_of_fields {
	    let eq = eq_pos[i];
	    let sp = prev_space(eq, line);
	    let mut word : Vec<char> = vec![];
	    for k in sp + 1 .. eq {
		word.push(line.chars().nth(k).unwrap());
	    }
	    field[line_num].push(word.iter().collect::<String>());
	}
	value.push(vec![]);
	for l in 0 .. num_of_fields - 1 {
	    let eq = eq_pos[l];
	    let eq_next = eq_pos[l+1];
	    let fieldlen :usize = field[line_num][l+1].len();
	    let mut value_word : Vec<char> = Vec::new();
	    for k in eq + 1 .. eq_next - fieldlen {
		value_word.push(line.chars().nth(k).unwrap());
	    }
	    value[line_num].push(value_word.iter().collect::<String>());
	}

	let eq = eq_pos[num_of_fields - 1];
	let mut last_field : Vec<char> = Vec::new();
	for i in eq+1 .. line.len() - 3 {
	    last_field.push(line.chars().nth(i).unwrap());
	}
	value[line_num].push(last_field.iter().collect::<String>());
	println!("Fields => ");
	for i in 0 .. num_of_fields {
	    println!("\t{} -> {}", field[line_num][i], value[line_num][i]);
	}
	println!();
    } else {
	println!("Text => {}", line);
    }
}

fn main() {
    let filename = "259.txt";
    let lines = read_file(filename);
    let mut field : Vec<Vec<String>> = Vec::new();
    let mut value : Vec<Vec<String>> = Vec::new();

    for i in 0 .. lines.len() {
	proc(i, &lines[i], &mut field, &mut value);
    }
}
