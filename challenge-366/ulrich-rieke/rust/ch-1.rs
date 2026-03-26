use std::io ;
use std::collections::VecDeque ;

fn main() {
    println!("Enter a sentence with some words separated by space!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let sentence = inline.trim_end( ) ;
    let mut all_words : VecDeque<&str> = inline.split_whitespace( ).collect( ) ;
    if sentence.starts_with( " " ) {
       all_words.push_front( "" ) ;
    }
    println!("Enter a word!" ) ;
    let mut wordline : String = String::new( ) ;
    io::stdin( ).read_line( &mut wordline ).unwrap( ) ;
    let word : &str = wordline.trim( ) ;
    println!("{}" , all_words.into_iter( ).filter( |&s| word.starts_with( s )
             ).count( ) ) ;
}
