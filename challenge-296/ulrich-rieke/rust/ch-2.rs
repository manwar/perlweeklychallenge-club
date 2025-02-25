use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Enter some positive integers separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut numbers : Vec<u32> = inline.trim( ).split_whitespace( ).map( 
	  |s| s.parse::<u32>( ).unwrap( ) ).collect( ) ;
    let len = numbers.len( ) ;
    if len < 4 { //we can't make a square from less than 4 sides!
       println!("false") ;
    }
    else {
       if len == 4 { //all sides have to be equal!
	  println!("{}" , numbers.into_iter( ).all_equal( ) ) ;
       }
       else {//see whether the sum of numbers is divisible by 4 and
	  //whether the rest of numbers which are not the maximum
	  //add up to the sum of the maximum number
	  let result : bool = numbers.iter( ).sum::<u32>( ) % 4 == 0 && {
	     numbers.sort( ) ;
	     let maxi = numbers[len - 1] ;
	     let counts = numbers.into_iter( ).counts( ) ;
	     let maxcount : usize = *counts.get( &maxi ).unwrap( ) ;
	     let maxsum : u32 = (4 - maxcount as u32) * maxi ;
	     let mut restsum : u32 = 0 ;
	     for ( k , v ) in &counts {
		if *k != maxi {
		   restsum += (*v as u32) * k ;
		}
	     }
	     restsum == maxsum 
	  } ;
	  println!("{}" , result) ;
       }
    }
}
