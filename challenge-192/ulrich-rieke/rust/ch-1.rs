use std::io ;

fn main() {
  println!("Enter a positive integer!") ;
  let mut inline : String = String::new( ) ;
  io::stdin( ).read_line( &mut inline ).unwrap( ) ;
  let entered_line : &str = &*inline ;
  let mut number : i32 = entered_line.trim( ).parse::<i32>( ).unwrap( ) ;
  let mut binary_digits : Vec<i32>  = Vec::new( ) ;
  while number != 0 {
      binary_digits.push( number % 2 ) ;
      number /= 2 ;
  }
  let mut reversed : Vec<i32> = Vec::new( ) ;
  binary_digits.iter( ).rev( ).for_each( | i | reversed.push( *i ) ) ;
  for pos in 0..reversed.len( ) {
      if reversed[ pos ] == 0 {
    reversed[ pos ] = 1 ;
      }
      else {
    reversed[ pos ] = 0 ;
      }
  }
  let mut sum : i32 = 0 ;
  let mut multiplier : i32 = 1 ;
  let mut iter = reversed.iter( ) ;
  while let Some( n ) = iter.next_back( ) {
      sum += *n * multiplier ;
      multiplier *= 2 ;
  }
  println!("{}" , sum ) ;
}
