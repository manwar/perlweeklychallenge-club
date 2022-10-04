use std::io ;

fn main() {
    println!("Please enter an MAC address in the form hhhh.hhhh.hhhh!") ;
    let mut input : String = String::new( ) ;
    io::stdin( ).read_line( &mut input ).unwrap( ) ;
    let mut entered_line : &str = &*input ;
    entered_line = entered_line.trim( ) ;
    let mut from : usize = 0 ;
    let mut to : usize = 1 ;
    let mut chunks : Vec<&str> = Vec::new( ) ;
    while to < input.len( ) {
      chunks.push( &entered_line[from..=to] ) ;
      from += 2 ;
      to += 2 ;
      match entered_line.chars( ).nth( from ) {
      Some ( '.' ) => { from += 1 ; to += 1 ; } ,
          None          => {} ,
      _            => {} ,
      }
    }
    let mut outputstring : String = String::new( ) ;
    for s in chunks {
      outputstring.push_str( &s.to_string( ) ) ;
      outputstring.push( ':' ) ;
    }
    println!("{}" , &outputstring[0..outputstring.len( ) - 1] ) ;
}
