use std::io ;
use itertools::Itertools ;

fn is_special( nums : &Vec<i32> ) -> bool {
  nums[0] + nums[1] + nums[2] == nums[3]
}

fn main() {
  println!("Please enter at least 4 integers, separated by blanks!") ;
  let mut inline : String = String::new( ) ;
  io::stdin( ).read_line( &mut inline ).unwrap( ) ;
  let entered_line : &str = &*inline ;
  let numbers : Vec<i32> = entered_line.split_whitespace( ).map(
    | s | s.trim( ).parse::<i32>( ).expect( "Could not parse!" ))
      .collect( ) ;
  let mut how_many : i32 = 0 ;
  for v in numbers.into_iter( ).combinations( 4 ) {
      if is_special( &v ) {
    how_many += 1 ;
      }
  }
  println!("{}" , how_many ) ;
}e
