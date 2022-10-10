use std::io ;
use std::io::BufRead ;

fn main() -> io::Result<( )> {
  println!("Please enter strings of single letters and digits, separated by blanks!") ;
  println!("Enter <return> to end!" ) ;
  let mut lines = io::stdin( ).lock( ).lines( ) ;
  let mut user_input = String::new( ) ;
  while let Some( line ) = lines.next( ) {
      let last_input = line.unwrap( ) ;
      if last_input.len( ) == 0 {
    break ;
      }
      else {
    user_input.push_str("\n" ) ;
      }
      user_input.push_str( &last_input ) ;
  }
  let all_lines : Vec<&str> = user_input.split("\n").collect( ) ;
  let mut all_letters : Vec<Vec<char>> = Vec::new( ) ;
  let mut all_digits : Vec<Vec<char>> = Vec::new( ) ;
  for a_line in all_lines {
      let mut current_letters : Vec<char> = Vec::new( ) ;
      let mut current_digits : Vec<char> = Vec::new( ) ;
      let string = a_line.to_string( ) ;
      for c in string.chars( ) {
    if c.is_numeric( ) {
        current_digits.push( c ) ;
    }
    if c.is_lowercase( ) {
        current_letters.push( c ) ;
    }
      }
      if current_digits.len( ) > 0 {
    all_digits.push( current_digits.clone( ) ) ;
      }
      if current_letters.len( ) > 0 {
    all_letters.push( current_letters.clone( ) ) ;
      }
  }
  println!("{:?} and {:?}" , all_digits , all_letters) ;
  Ok(())
}
