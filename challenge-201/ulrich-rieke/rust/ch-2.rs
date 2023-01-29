
use itertools::Itertools ;
use std::env ;

fn main() {
    let mut arguments : Vec<String> = Vec::new( ) ;
    for arg in env::args( ) {
      arguments.push( arg ) ;
    }
    let number : i32 = arguments[1].parse::<i32>( ).unwrap( ) ;
    let mut heapsum : i32 = 2 ; //one heap with n pennies and n heaps with
    //one penny
    for n in 2..=number - 1 {
      let mut it = (1..=number).combinations_with_replacement( n as usize) ;
      while let Some( v ) = it.next( ) {
      if v.iter( ).sum::<i32>( ) == number {
        heapsum += 1 ;
      }
      }
    }
    println!("{}" , heapsum ) ;
}
