use std::io ;
use std::collections::HashMap ;

fn main( ) {
  println!("Please enter some integers, separated by a blank!" ) ;
  let mut input = String::new( ) ;
  io::stdin( ).read_line( &mut input ).unwrap( ) ;
  let entered_line : &mut str = &mut input[..] ;
  let nums: Vec<&str> = entered_line.split( " ").collect( ) ;
  let numbers: Vec<i32> = nums.iter().map( |s| s.trim().parse( ).unwrap( )).collect( ) ;
  let mut frequencies : HashMap<i32 , usize> = HashMap::new( ) ;
  let mut maximum = numbers[0] ;
  let mut max_pos = 0 ;
  for pos in 1 .. numbers.len( ) {
      if numbers[ pos ] > maximum {
    if frequencies.get( & numbers[ pos ] ).is_none( )  {
        maximum = numbers[ pos ] ;
        max_pos = pos ;
    }
      }
      *frequencies.entry( numbers[ pos ] ).or_insert( 0 ) += 1 ;
  }
  println!("{}" , max_pos) ;
}
