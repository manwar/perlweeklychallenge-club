use std::io ;

fn main() {
  println!("Please print more than 3 integers, separated by a blank!" ) ;
  let mut inline : String = String::new( ) ;
  io::stdin( ).read_line( &mut inline ).unwrap( ) ;
  let entered_line : &str = &*inline ;
  let numbers : Vec<i32> = entered_line.split_whitespace( ).map(
    | s | s.trim( ).parse::<i32>( ).expect( "Could not parse number!" )).
      collect( ) ;
  let sv : &[i32] = numbers.as_slice( ) ;
  let mut iter = sv.windows( 3 ) ;
  let mut result : i32 = 0 ;
  while let Some( s ) = iter.next( ) {
      if s.iter( ).all( |&n| n % 2 == 1 ) {
    result = 1 ;
      }
  }
  println!("{}" , result) ;
}
