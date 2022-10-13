use std::{io , cmp} ;

fn main()  {
  let mut first_line : Vec<&str> = Vec::new( ) ;
  println!("Please enter strings of letters and digits , separated by blanks!") ;
  let mut line : String = String::new( ) ;
  io::stdin( ).read_line( &mut line ).unwrap( ) ;
  let entered : &str = &*line ;
  let mut iter = entered.split_whitespace( ) ;
  while let Some( chunk ) = iter.next( ) {
      first_line.push( chunk ) ;
  }
  let mut second_line: Vec<&str> = Vec::new( ) ;
  println!("Enter some other letters and digits, separated by blanks!" ) ;
  let mut line:String = String::new( ) ;
  io::stdin( ).read_line( &mut line ).unwrap( ) ;
  let entered : &str = &*line ;
  let mut iter = entered.split_whitespace( ) ;
  while let Some( chunk ) = iter.next( ) {
      second_line.push( chunk ) ;
  }
  let smaller: usize = cmp::min( first_line.len( ) , second_line.len( ) ) ;
  for i in 0..smaller {
      print!("{:?} , {:?} ," , first_line[i] , second_line[i] ) ;
  }
  println!() ;
}
