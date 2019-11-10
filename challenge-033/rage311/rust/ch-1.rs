use std::collections::BTreeMap;
use std::env;
use std::fs;
use std::path::PathBuf;
use std::process::exit;

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Error: need filename arguments");
        exit(1);
    };

    args[1..].iter()
        .map(|file| (file, fs::read_to_string(PathBuf::from(file))) )
        .filter(|(file, content)| match content {
            Ok(_) => true,
            Err(e) => {
                eprintln!("{}: ({})", e, file);
                false
            }
        })
        .for_each(|(file, content)| {
            let input = content.unwrap();

            let mut found: BTreeMap<char, u16> = BTreeMap::new();

            input.to_lowercase()
                .chars()
                .filter(|&c| c >= 'a' && c <= 'z')
                .for_each(|c| *(found.entry(c).or_insert(0)) += 1 );

            println!("{}", file);
            found.keys()
                .for_each(|key|
                    println!("{}: {}", key, found.get(&key).unwrap())
                );
            println!();
        });
}

/* $ ./ch-1 ch-1.rs ch-2.rs
 * Output:
 *
 * ch-1.rs
a: 26
b: 5
c: 22
d: 11
e: 64
f: 25
g: 8
h: 9
i: 26
k: 5
l: 25
m: 10
n: 40
o: 22
p: 17
r: 38
s: 27
t: 47
u: 19
v: 3
w: 4
x: 2
y: 5
z: 1

ch-2.rs
a: 7
c: 15
d: 2
e: 25
f: 6
g: 2
h: 5
i: 16
j: 4
l: 11
m: 12
n: 20
o: 28
p: 12
r: 19
s: 15
t: 25
u: 13
v: 6
w: 5
*/
