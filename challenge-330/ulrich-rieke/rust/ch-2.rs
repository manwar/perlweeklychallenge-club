use std::io ;

fn convert( sentence : &str ) -> String {
   let words : Vec<&str> = sentence.split_whitespace( ).collect( ) ;
   let mut result : String = String::new( ) ;
   for w in words {
      if w.chars( ).count( ) < 3 {
	 for c in w.chars( ) {
	    if c.is_ascii_uppercase( ) {
	       result.push( c.to_ascii_lowercase( ) ) ;
	    }
	 }
      }
      else {
	 for c in w.chars( ) {
	    if c == w.chars( ).nth(0).unwrap( ) {
	       result.push( c.to_ascii_uppercase( ) ) ;
	    }
	    else {
	       result.push( c.to_ascii_lowercase( ) ) ;
	    }
	 }
      }
      result.push( ' ' ) ;
   }
   result.pop( ) ;
   result 
}


fn main() {
    println!("Enter a string with several words separated by space!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let input : &str = inline.trim( ) ;
    println!("{:?}" , convert( input ) ) ;
}
