use std::io ;

fn main( ) {
  println!("Enter some words, separated by blanks!" ) ;
  let mut inline : String = String::new( ) ;
  io::stdin( ).read_line( &mut inline ).unwrap( ) ;
  let mut regiline : String = String::new( ) ;
  println!("Enter a registration numbers, separated by blanks!" ) ;
  io::stdin( ).read_line( &mut regiline ).unwrap( ) ;
  let entered_line : &str = &*inline ;
  let words : Vec<&str> = entered_line.split_whitespace( ).map( | s |
    s.trim( ) ).collect( ) ;
  let regi : &str = &*regiline ;
  let registration : Vec<&str> = regi.split_whitespace( ).map( | s |
    s.trim( ) ).collect( ) ;
  let mut all_lowers : String = String::new( ) ;
  for w in registration {
      for c in w.chars( ) {
    if c.is_alphabetic( ) {
        all_lowers.push( c.to_ascii_lowercase( ) ) ;
    }
      }
  }
  let reg : &str = all_lowers.as_str( ) ;
  let selected : Vec<&&str> = words.iter( ).filter( | &s |
    reg.chars( ).all( | l | s.contains( *&l ))).collect( ) ;
  println!("{:?}" , selected ) ;
}
