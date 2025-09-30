use std::io ;

fn main() {
    println!("Enter a string with English letters only!");
    let mut firstline : String = String::new( ) ;
    io::stdin( ).read_line( &mut firstline ).unwrap( ) ;
    let first_words : Vec<&str> = firstline.trim( ).split_whitespace( ).collect( ) ;
    println!("Enter some letters separated by whitespace!") ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline ).unwrap( ) ;
    let second_words : Vec<&str> = secondline.trim( ).split_whitespace( ).collect() ;
    let mut forbidden_chars : Vec<char> = Vec::new( ) ;
    for w in &second_words {
       for c in w.chars( ) {
	  forbidden_chars.push( c ) ;
       }
    }
    println!("{}" , first_words.into_iter( ).filter( |&w| {
	     w.chars( ).all( |c| ! forbidden_chars.contains( &c ) )
	     }).count( ) ) ;
}
