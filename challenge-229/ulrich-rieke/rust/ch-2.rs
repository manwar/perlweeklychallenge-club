use std::io ;
use std::io::{BufRead} ;
use std::collections::HashSet ;

fn main() -> io::Result<( )> {
    println!("Enter 3 lines of integers, separated by blanks !");
    let mut count : usize = 0 ;
    let mut all_numbers : Vec<Vec<i32>> = Vec::new( ) ;
    let mut lines = io::stdin( ).lock( ).lines( ) ;
    while count < 3 {
      if let Some( line ) = lines.next( ) {
       let last_input = line.unwrap( ) ;
       let entered_line : &str = &*last_input ;
       let numbers : Vec<i32> = entered_line.split_whitespace( ).map( 
	     | s | s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
       all_numbers.push( numbers ) ;
      }
      if count == 3 {
	 break ;
      }
      count += 1 ;
    }
    //we look for the union of all pairwise intersections of the number 
    //arrays we entered
    let mut s1 : HashSet<i32> = HashSet::new( ) ;
    let mut s2 : HashSet<i32> = HashSet::new( ) ;
    let mut s3 : HashSet<i32> = HashSet::new( ) ;
    for i in &all_numbers[ 0 ] {
       s1.insert( *i ) ;
    }
    for i in &all_numbers[1] {
       s2.insert( *i ) ;
    }
    for i in &all_numbers[ 2 ] {
       s3.insert( *i ) ;
    }
    let mut first_intersect : HashSet<i32> = HashSet::new( ) ;
    for e in s1.intersection( &s2 ) {
       first_intersect.insert( *e ) ;
    }
    let mut second_intersect : HashSet<i32> = HashSet::new( ) ;
    for e in s2.intersection( &s3 ) {
       second_intersect.insert( *e ) ;
    }
    let mut third_intersect : HashSet<i32> = HashSet::new( ) ;
    for e in s1.intersection( &s3 ) {
       third_intersect.insert( *e ) ;
    }
    let mut result : HashSet<i32> = HashSet::new( ) ;
    for i in first_intersect.union( &second_intersect ) {
       result.insert( *i ) ;
    }
    for i in second_intersect.union( &third_intersect ) {
       result.insert( *i ) ;
    }
    let mut nums : Vec<i32> = Vec::new( ) ;
    for i in result {
       nums.push( i ) ;
    }
    nums.sort( ) ;
    println!("{:?}" , nums ) ;
    Ok(())
}
