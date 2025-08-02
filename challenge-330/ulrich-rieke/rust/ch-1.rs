use std::io ;

fn main() {
    println!("Enter a string consisting of lowercase English letters and digits!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let input : &str = inline.trim( ) ;
    let mut in_chars : Vec<char> = Vec::new( ) ;
    for c in input.chars( ) {
       in_chars.push( c ) ;
    }
    while let Some( pos ) = in_chars.iter( ).position( |c| c.is_digit( 10 ) ) {
       if pos > 0 {
	  in_chars.remove( pos - 1 ) ;
	  in_chars.remove( pos - 1 ) ;
       }
       else {
	  in_chars.remove( 0 ) ;
       }
    }
    let mut result : String = String::new( ) ;
    for c in in_chars {
       result.push( c ) ;
    }
    println!("{:?}" , result ) ;
}
