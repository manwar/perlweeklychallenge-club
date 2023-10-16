use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Please enter some strings, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let all_strings : Vec<&str> = entered_line.split_whitespace( ).map( 
	  | s | s.trim( ) ).collect( ) ;
    println!("Enter an allowed string!") ;
    let mut stringline : String = String::new( ) ;
    io::stdin( ).read_line( &mut stringline ).unwrap( ) ;
    let allowed : &str = stringline.as_str( ).trim( ) ;
    let mut allowed_chars : HashSet<char> = HashSet::new( ) ;
    for c in allowed.chars( ) {
       allowed_chars.insert( c ) ;
    }
    let ct : usize = all_strings.iter( ).filter( | &s | 
	  s.chars( ).all( | l | allowed_chars.contains( & l ) ) ).count( ) ;
    println!("{}" , ct ) ;
}
