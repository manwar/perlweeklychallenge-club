use itertools::Itertools ;
use std::{io , cmp} ;

fn is_valid( positions : &Vec<usize> ) -> bool {
  let len : usize = positions.len( ) ;
  let mut pos : usize = 0 ;
  while pos != len {
      if positions[ pos ] > positions[ pos + 1 ] {
    return false ;
      }
      else {
    pos += 2 ;
      }
  }
  true
}

//the basic idea is to create permutations of the integer positions
//such a permutation is valid if for all pairs of neighbouring positions
//the left partner is not larger than the right one
//then we find the minima in the original, sum them up and compare them
//to the maximum
fn main() {
    println!("Please enter an even number of integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline).unwrap( ) ;
    let entered_line: &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map(
      | s | s.trim( ).parse::<i32>( ).unwrap( )).collect( ) ;
    let len = numbers.len( ) ;
    let mut maximum : i32 = 0 ;
    for v in (0..len).permutations( len ) {
      if is_valid( &v ) {
      let mut minima : Vec<i32> = Vec::new( ) ;
      let mut i : usize = 0 ;
      while i != len {
        minima.push( cmp::min( numbers[ v[i]] , numbers[ v[ i + 1 ]] )) ;
        i += 2 ;
      }
      let local_sum : i32 = minima.iter( ).sum( ) ;
      if local_sum > maximum {
        maximum = local_sum ;
      }
      }
    }
    println!("{}" , maximum) ;
}
