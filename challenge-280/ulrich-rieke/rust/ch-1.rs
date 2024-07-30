use std::io ;
use std::collections::HashMap ;

fn main() {
    println!("Enter a word with English lowercase letters only!");
    let mut inline : String = String::new( ) ;
    io::stdin().read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let mut frequencies = HashMap::new( ) ;
    let mut result : char = ' ' ;
    for c in entered_line.chars( ) {
       frequencies.entry(c).and_modify( |counter| *counter += 1 ).
	  or_insert( 1 ) ;
       if *frequencies.get( &c ).unwrap( ) == 2 {
	  result = c ;
	  break ;
       }
    }
    println!("{}" , result ) ;
}
