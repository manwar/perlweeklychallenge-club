use std::io ;
use itertools::Itertools ;

fn condition( subset : &Vec<&str> , my_x : usize , my_y : usize ) -> bool {
   let mut zeroes : usize = 0 ;
   let mut ones : usize = 0 ;
   for word in subset {
      for c in word.chars( ) {
	 if c == '0' {
	    zeroes += 1 ;
	 }
	 if c == '1' {
	    ones += 1 ;
	 }
      }
   }
   zeroes == my_x && ones == my_y 
}

fn main() {
    println!("Enter some binary strings separated by whitespace!");
    let mut binline : String = String::new( ) ;
    io::stdin( ).read_line( &mut binline ).unwrap( ) ;
    let binstrings : Vec<&str> = binline.trim( ).split_whitespace( ).
       collect( ) ;
    println!( "Enter a number x for the 0's!" ) ;
    let mut xline : String = String::new( ) ;
    io::stdin( ).read_line( &mut xline ).unwrap( ) ;
    let x : usize = xline.trim( ).parse::<usize>( ).unwrap( ) ;
    println!("Enter a number y for the 1's!" ) ;
    let mut yline : String = String::new( ) ;
    io::stdin( ).read_line( &mut yline ).unwrap( ) ;
    let y : usize = yline.trim( ).parse::<usize>( ).unwrap( ) ;
    let subsets : Vec<Vec<&str>> = binstrings.into_iter( ).
       powerset( ).collect( ) ;
    let selected : Vec<Vec<&str>> = subsets.into_iter( ).filter( |v| 
      condition( &v , x , y ) ).collect( ) ;
    let mut sizes : Vec<usize> = Vec::new( ) ;
    selected.into_iter( ).map( |vec| vec.len( ) ).for_each( |n| 
	  sizes.push( n )) ;
    println!("{}" , sizes.into_iter( ).max( ).unwrap( ) ) ;
}
