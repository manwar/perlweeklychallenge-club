use std::io ;

fn main() {
  println!("Please enter some unique integers, separated by a blank!" ) ;
  let mut inline : String = String::new( ) ;
  io::stdin( ).read_line( &mut inline ).unwrap( ) ;
  let entered_line : &str = &*inline ;
  let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
    s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
  let len = numbers.len( ) ;
  let mut missing_numbers : Vec<i32> = Vec::new( ) ;
  for n in 0..=len {
      let found = numbers.iter( ).find( | i | **i == n as i32 ) ;
      if found.is_none( ) {
    missing_numbers.push( n as i32 ) ;
      }
  }
  println!("{:?}" , missing_numbers ) ;
}
