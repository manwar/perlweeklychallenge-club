use itertools::Itertools ;
use std::io ;

fn is_cute( a_vec: &Vec<i32> ) -> bool {
  let c = | t : ( usize , &i32 ) | {
      *t.1 % ( (t.0 + 1) as i32 ) == 0 ||
    ( (t.0 + 1) as i32 ) % *t.1 == 0
  } ;
  a_vec.iter().enumerate( ).all( c )
}

fn main() {
  println!("Please enter a number between 2 and 15!") ;
  let mut input : String = String::new( ) ;
  io::stdin().read_line( &mut input).unwrap( ) ;
  let mut entered_line : &str = &*input ;
  entered_line = entered_line.trim( ) ;
  let limit : i32 = entered_line.parse::<i32>( ).unwrap( ) ;
  let l : usize = limit as usize ;
  let perms = (1..=limit).permutations( l ) ;
  let mut count : i32 = 0 ;
  for v in perms {
      if is_cute( & v ) {
    count += 1 ;
      }
  }
  println!("{}" , count ) ;
}
