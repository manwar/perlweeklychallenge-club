use std::io ;
use std::collections::{HashMap , HashSet} ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let first_line : &str = inline.as_str( ).trim( ) ;
    println!("Enter some distinct integers, that are a subset of above!" ) ;
    let mut sec_line : String = String::new( ) ;
    io::stdin( ).read_line( &mut sec_line ).unwrap( ) ;
    let second_line : &str = sec_line.as_str( ).trim( ) ;
    let first_numbers : Vec<i32> = first_line.split_whitespace( ).map( 
	  |s| s.parse::<i32>( ).unwrap( )).collect( ) ;
    let second_numbers : Vec<i32> = second_line.split_whitespace( ).map( 
	  |s| s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    //frequencies of the numbers first entered
    let mut frequencies = HashMap::new( ) ;
    for n in &first_numbers {
       frequencies.entry( n ).and_modify( |counter| *counter += 1 ).
	  or_insert( 1 ) ;
    }
    //result holds the final number vector
    let mut result : Vec<i32> = Vec::new( ) ;
    //we now form a set of the second list of integers entered
    //we do that while traversing second_numbers for adding as 
    //many copies to the result set as in the first_numbers vector
    let mut second_set : HashSet<i32> = HashSet::new( ) ;
    for n in second_numbers {
       let f = frequencies.get( &n ).unwrap( ) ;
       for _ in 0..*f {
	  result.push( n ) ;
       }
       second_set.insert( n ) ;
    }
    let mut first_set : HashSet<i32> = HashSet::new( ) ;
    for n in &first_numbers {
       first_set.insert( *n ) ;
    }
    let mut diff_vec : Vec<i32> = Vec::new( ) ;//difference vector
    for d in first_set.difference( &second_set ) {
       diff_vec.push( *d ) ;
    }
    diff_vec.sort( ) ;
    diff_vec.into_iter( ).for_each( | i |  { 
	  let f = frequencies.get( &i ).unwrap( ) ;
	  for _ in 0..*f {
	    result.push( i ) ;
          }
    }) ;
    println!("{:?}" , result ) ;
}
