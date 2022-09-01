use std::io ;
fn main() {
  println!("Please enter some integers, separated by a blank!" ) ;
  let mut input = String::new( ) ;
  io::stdin( ).read_line( &mut input ).unwrap( ) ;
  let entered_line : &mut str = &mut input[..] ;
  let nums: Vec<&str> = entered_line.split( " ").collect( ) ;
  let numbers: Vec<u32> = nums.iter().map( |s| s.trim().parse( )
    .unwrap( ) ) .collect( ) ;
  let mut number_input = String::new( ) ;
  println!("Please enter an integer!") ;
  io::stdin( ).read_line( &mut number_input).unwrap( ) ;
  let number : &mut str = &mut number_input[..] ;
  let num: u32 = number.trim( ).parse( ).unwrap( ) ;
  let solution: Vec<u32> = numbers.iter( ).filter( |x| **x > num )
      .cloned().collect( ) ;
  println!("{:?}" , solution);
}
