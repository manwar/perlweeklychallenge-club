use std::io ;

fn main() {
  println!("Please enter some strings, separated by a blank!" ) ;
  let mut input : String = String::new( ) ;
  io::stdin( ).read_line( &mut input ).unwrap( ) ;
  let entered_line = &*input ;
  let mut outputwords : Vec<&str> = Vec::new( ) ;
  let mut iter = entered_line.split_whitespace( ) ;
  while let Some( word ) = iter.next( ) {
      outputwords.push( word ) ;
  }
  for s in outputwords {
      print!("{} " , s.replacen( char::is_alphanumeric , "x" , 4 )) ;
  }
  println!() ;
}
