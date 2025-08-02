use std::io ;

fn main() {
    println!("Enter some words, separated by blanks!");
    let mut firstline : String = String::new( ) ;
    io::stdin( ).read_line( &mut firstline ).unwrap( ) ;
    let firstwords : &str = &*firstline ;
    println!("Enter some more words, separated by blanks!" ) ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline ).unwrap( ) ;
    let secondwords : &str = &*secondline ;
    let first_col : Vec<&str> = firstwords.split_whitespace( ).map( | s | s.trim( ) ).
       collect( ) ;
    let second_col : Vec<&str> = secondwords.split_whitespace( ).map( | s | s.trim( ) ).
       collect( ) ;
    let mut all_words : Vec<&str> = Vec::new( ) ;
    for w in &first_col {
       all_words.push( w ) ;
    }
    for w in &second_col {
       all_words.push( w ) ;
    }
    println!("{:?}" , all_words.into_iter( ).filter( | &w | {
	     (first_col.iter( ).filter( | st | **st == w ).count( ) == 1 &&
	     second_col.iter( ).filter( |st | **st == w ).count( ) == 0 ) ||
             (first_col.iter( ).filter( | st | **st == w ).count( ) == 0 &&
	     second_col.iter( ).filter( |st | **st == w ).count( ) == 1 ) } ).
	  collect::<Vec<&str>>( ) ) ;
}
