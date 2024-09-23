use std::collections::HashSet;

struct Hash {
    key: HashSet<String>,
}

impl Hash {
    fn new() -> Self {
        Hash {
            key: HashSet::new(),
        }
    }

    fn contains(&self, entry: &str) -> bool {
        self.key.contains(entry)
    }

    fn insert(&mut self, entry: &str) {
        self.key.insert(entry.to_string());
    }
}

fn intersection(a: &str, b: &str) -> bool {
    let entries_a: Vec<&str> = a.split_whitespace().collect();
    for entry_a in entries_a {
        let entries_b: Vec<&str> = b.split_whitespace().collect();
        for entry_b in entries_b {
            if entry_a == entry_b {
                return true;
            }
        }
    }
    false
}

fn merge(c: &mut Vec<String>) {
    for i1 in 0..c.len() - 1 {
        for i2 in i1 + 1..c.len() {
            if intersection(&c[i1], &c[i2]) {
                let mut h = Hash::new();
                
                let entries1: Vec<&str> = c[i1].split_whitespace().collect();
                for entry1 in entries1 {
                    if !h.contains(entry1) {
                        h.insert(entry1);
                    }
                }

                let entries2: Vec<&str> = c[i2].split_whitespace().collect();
                for entry2 in entries2 {
                    if !h.contains(entry2) {
                        h.insert(entry2);
                    }
                }

                c[i1].clear();
                let merged: String = h.key.iter().map(|s| format!("{} ", s)).collect();
                c[i2] = merged;
            }
        }
    }
}

fn contigu(m: usize, n: usize, matrix: &[[char; 5]], entry: &str, c: &mut Vec<String>) {
    let mut blocks = vec![entry.to_string()];

    let mut changes = 1;
    while changes > 0 {
	changes = 0;
	for i in 0..blocks.len() {
            let block = &blocks[i];
            let mut parts = block.split('-');
            let y: usize = parts.next().unwrap().parse().unwrap();
            let x: usize = parts.next().unwrap().parse().unwrap();

            if x + 1 < n && matrix[y][x] == matrix[y][x + 1] {
		let new_entry: String = format!("{}-{}", y, x + 1);
		if !blocks.contains(&new_entry) {
		    blocks.push(new_entry);
		    changes += 1;
		}
            }

            if y + 1 < m && matrix[y][x] == matrix[y + 1][x] {
		let new_entry: String = format!("{}-{}", y + 1, x);
		if !blocks.contains(&new_entry) {
		    blocks.push(new_entry);
		    changes += 1;
		}
            }
	}
    } 

    let merged: String = blocks.iter().map(|s| format!("{} ", s)).collect();
    c.push(merged);
}

fn proc(m: usize, n: usize, matrix: &[[char; 5]]) {
    println!("Input: matrix =");
    for row in matrix {
        println!("\t{}", row.iter().collect::<String>());
    }

    let mut contig = Vec::new();
    contigu(m, n, matrix, "0-0", &mut contig);

    for i in 0..m {
        for j in 0..n {
            let entry = format!("{}-{}", i, j);
            let mut got_flag = false;

            for b in &contig {
                let s: Vec<&str> = b.split_whitespace().collect();
                if s.contains(&&entry[..]) {
                    got_flag = true;
                }
            }

            if !got_flag {
                contigu(m, n, matrix, &entry, &mut contig);
            }
        }
    }

    merge(&mut contig);

    let mut cnt = 0;
    for c in &contig {
        if !c.is_empty() {
            println!("{}", c);
            let len = c.matches('-').count();
            if cnt < len {
                cnt = len;
            }
        }
    }

    println!("\nOutput: {}\n", cnt);
}

fn main() {
    let matrix1: [[char; 5]; 4] = [
        ['x', 'x', 'x', 'x', 'o'],
        ['x', 'o', 'o', 'o', 'o'],
        ['x', 'o', 'o', 'o', 'o'],
        ['x', 'x', 'x', 'o', 'o'],
    ];
    proc(4, 5, &matrix1);

    let matrix2: [[char; 5]; 4] = [
        ['x', 'x', 'x', 'x', 'x'],
        ['x', 'o', 'o', 'o', 'o'],
        ['x', 'x', 'x', 'x', 'o'],
        ['x', 'o', 'o', 'o', 'o'],
    ];
    proc(4, 5, &matrix2);

    let matrix3: [[char; 5]; 4] = [
        ['x', 'x', 'x', 'o', 'o'],
        ['o', 'o', 'o', 'x', 'x'],
        ['o', 'x', 'x', 'o', 'o'],
        ['o', 'o', 'o', 'x', 'x'],
    ];
    proc(4, 5, &matrix3);
}
