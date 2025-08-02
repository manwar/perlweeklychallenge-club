use std::io ;
use itertools::Itertools ;

fn to_number( digits : &Vec<i32> ) -> i32 {
   let mut total : i32 = 0 ;
   let mut current_prod : i32 = 100 ;
   for n in digits {
      total += current_prod * *n ;
      current_prod /= 10 ;
   }
   total 
}

fn main() {
    println!("Enter at least 3 positive one-digit numbers!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut even_numbers : Vec<i32> = Vec::new( ) ;
    for ve in  numbers.into_iter( ).permutations( 3 ) {
       if ve[0] != 0 {
	  let num : i32 = to_number( &ve ) ;
	  if num % 2 == 0 {
	     even_numbers.push( num ) ;
	  }
       }
    }
    even_numbers.sort( ) ;
    even_numbers.dedup( ) ;
    println!("{:?}" , even_numbers ) ;
}
