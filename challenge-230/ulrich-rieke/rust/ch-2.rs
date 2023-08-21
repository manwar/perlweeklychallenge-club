use std::io ;

fn main() {
    println!("Enter some words, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    println!("Enter a prefix!") ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline ).unwrap( ) ;
    let another_line : &str = &*secondline ;
    let prefix : &str = another_line.trim( ) ;
    let words : Vec<&str> = entered_line.split_whitespace( ).map( 
	  | s | s.trim( ) ).collect( ) ;
    println!("{}" , words.iter( ).filter( | &w | w.starts_with( prefix ) ).
	  count( ) ) ;
}
