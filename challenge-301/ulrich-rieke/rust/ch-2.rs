use std::io ;
use itertools::Itertools ;

//the Hamming distance is the difference in the number of ones between
//the number that is created by bitwise orring and bitwise anding two
//numbers

fn distance( first : u32 , second : u32 ) -> u32 {
   let orred : u32 = first | second ;
   let anded : u32 = first & second ;
   orred.count_ones( ) - anded.count_ones( ) 
}

fn main() {
    println!("Enter some integers separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<u32> = inline.trim( ).split_whitespace( ).map( 
	  |s| s.parse::<u32>( ).unwrap( ) ).collect( ) ;
    let mut sum : u32 = 0 ;
    for vec in numbers.into_iter( ).combinations( 2 ) {
       let dist : u32 = distance( vec[0] , vec[1] ) ;
       sum += dist ;
    }
    println!("{}" , sum ) ;
}
