use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Enter a word consisting of lowercase letters and digits only!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let after : String = inline.trim( ).replace( |c: char| c.is_alphabetic( ) , " " );
    let remaining : Vec<&str> = after.as_str( ).split(' ').collect( ) ;
    let numbers : Vec<i32> = remaining.into_iter( ).filter( |&s| {
	  s.chars( ).count( ) > 0 && s.chars( ).all( |c| c.is_digit( 10 ))
	  } ).map( |s| {
	     let mut sum : i32 = 0 ;
	     let mut pos : i32 = 1 ;
	     let mut iter = s.chars( ).rev( ) ;
	     while let  Some( n ) = iter.next( ) {
	       let oldpos : i32 = pos ;
	       pos *= n.to_digit( 10 ).unwrap( ) as i32 ;
	       sum += pos ;
	       pos = oldpos ;
	       pos *= 10 ;
	    }
	    sum 
	    } ).collect( ) ;
    let mut uniques : HashSet<i32> = HashSet::new( ) ;
    for n in &numbers {
       uniques.insert( *n ) ;
    }
    let mut solution : Vec<i32> = Vec::new( ) ;
    for n in &numbers {
       if uniques.remove( &*n ) {
	  solution.push( *n ) ;
       }
    }
    println!("{:?}" , solution ) ;
}
		
