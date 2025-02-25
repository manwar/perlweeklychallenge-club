use std::io ;
use std::collections::HashSet ;

fn find_set_length( nums : &Vec<usize> , mut index : usize ) -> usize {
   let mut numberset : HashSet<usize> = HashSet::new( ) ;
   while numberset.insert( nums[index] ) {
      index = nums[index] ;
   }
   numberset.len( ) 
}

fn main() {
    println!("Enter a permutation of positive integers 0 to n - 1!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<usize> = inline.trim( ).split_whitespace( ).map( |s| 
	  s.parse::<usize>( ).unwrap( ) ).collect( ) ;
    let len : usize = numbers.len( ) ;
    let mut lengths : Vec<usize> = Vec::new( ) ;
    for n in 0usize..len {
       let length = find_set_length( &numbers , n ) ;
       lengths.push( length ) ;
    }
    println!("{}" , lengths.into_iter( ).max( ).unwrap( ) ) ;
}
