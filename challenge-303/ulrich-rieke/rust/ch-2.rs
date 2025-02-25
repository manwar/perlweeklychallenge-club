use std::io ;
use itertools::Itertools ;

fn create_partition( numbers : &Vec<i32> ) -> Vec<Vec<i32>> {
   let mut a_partition : Vec<Vec<i32>> = Vec::new( ) ;
   let mut current_vec : Vec<i32> = Vec::new( ) ;
   current_vec.push( numbers[0] ) ;
   let len : usize = numbers.len( ) ;
   for i in 1..len {
      if numbers[i].abs_diff( current_vec[0] ) == 1 {
	 current_vec.push( numbers[i] ) ;
      }
      else {
	 a_partition.push( current_vec.clone( ) ) ;
	 current_vec.clear( ) ;
	 current_vec.push( numbers[i] ) ;
      }
   }
   if current_vec.len( ) > 0 {
      a_partition.push( current_vec.clone( ) ) ;
   }
   a_partition 
}

fn find_sum( a_collection : &Vec<Vec<i32>> ) -> i32 {
   let mut sum : i32 = 0 ;
   for vec in a_collection {
      sum += vec[0] ;
   }
   sum 
}

fn main( ) {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin().read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<i32>( ).unwrap( )).collect( ) ;
    let mut sums : Vec<i32> = Vec::new( ) ;
    let len : usize = numbers.len( ) ;
    for vec in numbers.into_iter( ).permutations( len ) {
       let collection : Vec<Vec<i32>> = create_partition( &vec ) ;
       let sum : i32 = find_sum( &collection ) ;
       sums.push( sum ) ;
    }
    println!("{}" , sums.into_iter( ).max( ).unwrap( ) ) ;
}
