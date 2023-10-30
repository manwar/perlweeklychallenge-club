use std::io ;

fn main() {
    println!("Enter some words, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let first_line : &str = &*inline ;
    let first_words : Vec<&str> = first_line.split_whitespace( ).map( | s | 
	  s.trim( ) ).collect( ) ;
    println!("Enter some more words , separated by blanks!") ;
    let mut another_line : String = String::new( ) ;
    io::stdin( ).read_line( &mut another_line ).unwrap( ) ;
    let second_line : &str = &*another_line ;
    let second_words : Vec<&str> = second_line.split_whitespace( ).map( | s |
	  s.trim( ) ).collect( ) ;
    let mut concat_1 : String = String::new( ) ;
    first_words.iter( ).for_each( | s | concat_1.push_str( s ) ) ;
    let mut concat_2 : String = String::new( ) ;
    second_words.iter( ).for_each( | s | concat_2.push_str( s ) ) ;
    println!("{}" , concat_1 == concat_2 ) ;
}
