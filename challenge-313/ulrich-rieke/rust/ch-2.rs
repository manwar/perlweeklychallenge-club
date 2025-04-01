use std::io ;

fn main() {
    println!("Please enter a string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let trimmed = inline.trim( ) ;
    let mut finally_reversed : String = String::new( ) ;
    let mut ordinary_characters : Vec<char> = Vec::new( ) ;
    for c in trimmed.chars( ) {
       if c.is_ascii_alphabetic( ) {
	  ordinary_characters.push( c ) ;
       }
    }
    let mut reversed_chars : Vec<char> = Vec::new( ) ;
    let mut iter = ordinary_characters.into_iter( ).rev( ) ;
    while let Some( i ) = iter.next( ) {
       reversed_chars.push( i ) ;
    }
    for c in trimmed.chars( ) {
       if ! c.is_ascii_alphabetic( ) {
	  finally_reversed.push( c ) ;
       }
       else {
	  let d = reversed_chars.remove( 0 ) ;
	  finally_reversed.push( d ) ;
       }
    }
    println!("{:?}" , finally_reversed ) ;
}
