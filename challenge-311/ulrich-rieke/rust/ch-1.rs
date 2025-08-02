use std::io ;

fn main() {
    println!("Enter a string consisting of English letters!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered : &str = inline.trim( ) ;
    let letters : Vec<char> = entered.chars( ).map( |c| {
	  if c.is_ascii_lowercase( ) {
	    c.to_ascii_uppercase( ) 
	  }
	  else {
	    c.to_ascii_lowercase( ) 
	  }
	  } ).collect( ) ;
    let mut changed : String = String::new( ) ;
    for c in letters {
       changed.push( c ) ;
    }
    println!("{:?}" , changed ) ;
}
