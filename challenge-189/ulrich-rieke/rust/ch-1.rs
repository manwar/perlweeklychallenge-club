use std::io ;

fn main() {
  println!("Please enter a number of letters separated by blanks!") ;
  let mut inputline : String = String::new( ) ;
  io::stdin( ).read_line( &mut inputline ).unwrap( ) ;
  let entered_line : &str = &*inputline ;
  let mut characters : Vec<char> = entered_line.split_whitespace( )
      .map( |s| s.trim( ).parse::<char>( ).unwrap( )).collect( ) ;
  let char_slice = characters.as_mut_slice( ) ;
  char_slice.sort( ) ;
  println!("Enter a target character!") ;
  inputline.clear( ) ;
  io::stdin( ).read_line( &mut inputline).unwrap( ) ;
  let entered_line : &str = &*inputline ;
  let target : char = entered_line.trim( ).parse::<char>( ).unwrap( ) ;
  let len = char_slice.len( ) ;
  let mut current : usize = 0 ;
  let mut c : char = char_slice[current] ;
  while  c <= target {
      current += 1 ;
      if current > len - 1 {
    break ;
      }
      c = char_slice[ current ] ;
  }
  println!("{}" , c ) ;
}
