use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Enter a string with lowercase English letters and one ?!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let trimmed = inline.trim( ) ; 
    let mut characters : HashSet<char> = HashSet::new( ) ;
    for c in 'a'..='z' {
       characters.insert( c ) ;
    }
    let len : usize = trimmed.chars( ).count( ) ;
    let mut after : String = String::new( ) ;
    if let Some( pos ) = trimmed.find( '?' ) {
       let mut left_neighbour : char = ' ' ;
       let mut right_neighbour : char = ' ' ;
       if pos > 0 {
	  left_neighbour = trimmed.chars( ).nth(pos - 1).unwrap( ) ;
       }
       if pos < len - 1 {
	  right_neighbour = trimmed.chars( ).nth( pos + 1 ).unwrap( ) ;
       }
       let mut already_there : HashSet<char> = HashSet::new( ) ;
       already_there.insert( left_neighbour ) ;
       already_there.insert( right_neighbour ) ;
       let diff : HashSet<&char> = characters.difference( &already_there ).collect( ) ;
       if diff.len( ) > 0 {
	  let mut repl : String = String::new( ) ;
	  for x in diff.iter( ) {
              repl.push(**x) ;
	      break ;
	  }
	  let replacement = repl.as_str( ) ;
	  after = trimmed.replace( "?" , replacement ) ;
       }
    }
    println!("{:?}" , after ) ;
}
