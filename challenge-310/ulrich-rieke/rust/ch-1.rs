use std::io ;
use std::collections::HashSet ;
use std::io::BufRead ;

fn main() -> io::Result<( )> {
    println!("Enter some lines of integers , separated by blanks!");
    println!("Enter <return> to end entry!" ) ;
    let mut all_input : String = String::new( ) ;
    let mut lines = io::stdin( ).lock( ).lines( ) ;
    while let Some( line ) = lines.next( ) {
       let last_input = line.unwrap( ) ;
       if last_input.len( ) == 0 {
	  break ;
       }
       else {
	  all_input.push_str( &last_input ) ;
	  all_input.push_str( "\n" ) ;
       }
    }
    let total_line : &str = all_input.as_str( ).trim( ) ;
    let all_lines : Vec<&str> = total_line.split( "\n" ).collect( ) ;
    let mut all_arrays : Vec<HashSet<i32>> = Vec::new( ) ;
    all_lines.into_iter( ).map( | l | {
	  let numbers : Vec<i32> = l.split_whitespace( ).map( |s| 
		s.parse::<i32>( ).unwrap( ) ).collect( ) ;
	  numbers } ).map( |v| {
	     let mut a_set : HashSet<i32> = HashSet::new( ) ;
	     for n in v {
	       a_set.insert( n ) ;
	     } 
	     a_set }).for_each( |s| all_arrays.push( s.clone( ) ) ) ;
    let common : HashSet<_> = all_arrays.into_iter( ).reduce( |first_set , second_set| 
	     &first_set & &second_set).unwrap( ) ;
    let mut common_numbers : Vec<i32> = Vec::new( ) ;
    for n in common {
       common_numbers.push( n ) ;
    }
    common_numbers.sort( ) ;
    println!("{:?}" , common_numbers) ;
    Ok(())
}
