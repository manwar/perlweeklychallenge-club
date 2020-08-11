/* TASK #1
 * Square Secret Code
 *
 * The squate secret code mechanism first removes any space from the original message. Then it lays
 * down the message in a row of 8 columns. The coded message is then obtained by reading down the
 * columns going left to right.
 *
 * For example, the message is “The quick brown fox jumps over the lazy dog”.
 *
 * Then the message would be laid out as below:
 *
 * thequick
 * brownfox
 * jumpsove
 * rthelazy
 * dog
 *
 * The code message would be as below:
 *
 * tbjrd hruto eomhg qwpe unsl ifoa covz kxey
 *
 * Write a script that accepts a message from command line and prints the equivalent coded message.
 *
 *
 * Executing program and output:
 *
 * $ echo 'the quick brown fox jumps over the lazy dog' | ./ch-1
 * tbjrd hruto eomhg qwpe unsl ifoa covz kxey
 */

use std::io::{self, Read};

fn main() -> io::Result<()> {
    let mut buffer = String::new();
    io::stdin().read_to_string(&mut buffer)?;
    buffer = buffer.split_whitespace().collect();

    let mut final_words: Vec<String> = vec!["".to_string(); 8];

    for i in 0..buffer.len() {
        final_words[i % 8].push(buffer.chars().nth(i).unwrap());
    }

    println!("{}", final_words.join(" "));

    Ok(())
}
