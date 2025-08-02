use std::io ;
use std::collections::HashMap ;

fn main() {
    println!("Enter a word!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut frequencies : HashMap<char , usize> = HashMap::new( ) ;
    for c in inline.trim( ).chars( ) {
       frequencies.entry( c ).and_modify( |counter| *counter += 1 ).
	  or_insert( 1 ) ;
    }
    println!("{}" , frequencies.values( ).all( |n| n % 2 == 1 ) ) ;
}
