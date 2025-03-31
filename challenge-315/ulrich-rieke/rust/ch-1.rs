use std::io ;

fn main() {
    println!("Enter some words separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    println!("Enter a character!") ;
    let mut charstring : String = String::new( ) ;
    io::stdin( ).read_line( &mut charstring ).unwrap( ) ;
    let trimmed = charstring.trim( ) ;
    println!("{:?}" , words.into_iter( ).enumerate( ).filter( |p| p.1.contains(&trimmed))
	  .map( |p| p.0 ).collect::<Vec<usize>>( ) ) ;
}
