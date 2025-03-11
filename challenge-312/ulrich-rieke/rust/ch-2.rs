use std::io ;
use std::collections::{HashMap , HashSet} ;

fn main() {
    println!("Write a string with letters G, B and R and number of box!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let trimmed = inline.trim( ) ;
    let mut in_chars : Vec<char> = Vec::new( ) ;
    for c in trimmed.chars( ) {
       in_chars.push( c ) ;
    }
    let char_slice = in_chars.as_slice( ) ;
    let mut iter = char_slice.chunks( 2 ) ;
    let mut boxes : HashMap<char , HashSet<char>> = HashMap::new( ) ;
    while let Some( pair ) = iter.next( ) {
       boxes.entry( pair[1] ).and_modify( |set| {set.insert( pair[0] ) ;
	     }).or_insert( HashSet::from( [pair[0]] )) ;
    }
    println!("{}" , boxes.into_values( ).filter( |v| v.len( ) == 3 ).
	  count( ) ) ;
}
