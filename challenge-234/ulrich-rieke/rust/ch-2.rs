use std::io ;
use std::collections::HashSet ;
use itertools::Itertools ;

fn count ( num : u32 , numbers : &Vec<u32> ) -> usize {
   numbers.iter( ).filter( | d | **d == num ).count( ) 
}

fn main() {
    println!("Enter some positive integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut numbers : Vec<u32> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<u32>( ).unwrap( )).collect( ) ;
    numbers.sort( ) ;
    let mut uniques : HashSet<u32> = HashSet::new( ) ;
    for n in &numbers {
       uniques.insert( *n ) ;
    }
    let mut nums : Vec<u32> = Vec::new( ) ;
    for n in &uniques {
       nums.push( *n ) ;
    }
    let mut sum : usize = 0 ;
    for combi in nums.iter( ).combinations( 3 ) {
       let mut product : usize = 1 ;
       for n in &combi {
	  product *= count( **n , &numbers ) ;
       }
       sum += product ;
    }
    println!("{}" , sum ) ;
}
