use std::io ;
use std::io::BufRead ;

fn main() -> io::Result<( )> {
  println!("Please enter strings with 2 starting letters, followed by 4 digits!") ;
  println!("Enter <return> to end!" ) ;
  let mut input : Vec<String> = Vec::new( ) ;
  let mut lines = io::stdin( ).lock( ).lines( ) ;
  while let Some( line ) = lines.next( ) {
      let last_input = line.unwrap( ) ;
      if last_input.len( ) == 0 {
        break ;
      }
      else {
    input.push( last_input.to_string( )) ;
      }
  }
  let mut count : i32 = 0 ;
  let mut output : Vec<String> = Vec::new( ) ;
  for a_word in input {
      let word_ref : &str = &a_word.as_str( ) ;
      let letterpart : &str = &word_ref[2..=5] ;
      let mut combined = String::new( ) ;
      if count < 10 {
    combined = "0".to_owned( ) + &count.to_string( ) + &letterpart.to_owned( );
      }
      else {
    combined = count.to_string( ) + &letterpart.to_owned( ) ;
      }
      output.push( combined.clone( ) ) ;
      count += 1 ;
  }
  println!("{:?}" , output ) ;
  Ok(())
}
