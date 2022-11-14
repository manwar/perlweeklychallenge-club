use std::io ;

fn main() {
  println!("Enter a single word!") ;
  let mut inline : String = String::new( ) ;
  io::stdin( ).read_line( & mut inline ).unwrap( ) ;
  let mut entered_line : &str = &*inline ;
  entered_line = entered_line.trim( ) ;
  let tailstring : &str = &entered_line[1..] ;
  if (entered_line.chars( ).nth( 0 ).unwrap( ).is_uppercase( ) &&
    tailstring.chars( ).all( | c | c.is_lowercase( ))) ||
      entered_line.chars( ).all( | c | c.is_lowercase( ) ) ||
    entered_line.chars( ).all( | c | c.is_uppercase( )) {
      println!("1") ;
  }
  else {
      println!("0") ;
  }
}
