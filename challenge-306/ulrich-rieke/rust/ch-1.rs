use std::io ;

fn sum_of_subarrays( numbers : &Vec<u32> , l : usize ) -> u32 {
   if l == numbers.len( ) || l == 1 {
      numbers.iter( ).sum( ) 
   }
   else {
      let nu_slice = &numbers[..] ;
      let mut iter = nu_slice.windows( l ) ;
      let mut total : u32 = 0 ;
      while let Some( wi ) = iter.next( ) {
	 let a_sum : u32 = wi.iter( ).sum::<u32>( ) ;
         total += a_sum ;
      }
      total 
   }
}

fn main() {
    println!("Enter some positive integers separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<u32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<u32>( ).unwrap( ) ).collect( ) ;
    let len : usize = numbers.len( ) ;
    let lengths : Vec<usize> = (1..=len).filter( |&d| d % 2 == 1 ).collect( ) ;
    let mut subarraysums : Vec<u32> = Vec::new( ) ;
    lengths.into_iter( ).map( |l| sum_of_subarrays( &numbers , l ) ).for_each(
	  |n| subarraysums.push( n ) ) ;
    println!("{}" , subarraysums.into_iter( ).sum::<u32>( ) ) ;
}
