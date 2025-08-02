use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Enter a string!") ;
    let mut firststring : String = String::new( ) ;
    io::stdin( ).read_line( &mut firststring ).unwrap( ) ;
    println!("Enter a second string with repetitive errors!") ;
    let mut secondstring : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondstring ).unwrap( ) ;
    let firstword = firststring.trim( ) ;
    let secondword = secondstring.trim( ) ;
    //the basic idea is : if the set of characters in the second string
    //is the same as in the first one and the second string is longer than
    //the first the output is true else false
    let mut first_set : HashSet<char> = HashSet::new( ) ;
    let mut second_set : HashSet<char> = HashSet::new( ) ;
    for c in firstword.chars( ) {
       first_set.insert( c ) ;
    }
    for c in secondword.chars( ) {
       second_set.insert( c ) ;
    }
    println!("{}" , first_set == second_set && firstword.chars( ).count( )
	  != secondword.chars( ).count( ) ) ;
}
