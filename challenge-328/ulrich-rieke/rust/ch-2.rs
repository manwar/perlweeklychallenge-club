use std::io ;

fn main() {
    println!("Enter a string with English letters only!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut entered : &str = inline.trim( ) ;
    let mut trimmed : String = entered.into( ) ;
    let mut len : usize = entered.chars( ).count( ) ;
    let mut pos : usize = 0 ;
    while pos < len - 1 {
       let first_char : char = entered.chars( ).nth( pos ).unwrap( ) ;
       let second_char : char = entered.chars( ).nth( pos + 1 ).unwrap( ) ;
       if (first_char.to_ascii_lowercase( ) == second_char || 
	  first_char.to_ascii_uppercase( ) == second_char ) && 
          first_char != second_char {
	     trimmed.remove( pos ) ;
	     trimmed.remove( pos ) ;
	     entered = trimmed.as_str( ) ;
	     len = entered.chars( ).count( ) ;
	     if len == 0 {
		break ;
	     }
	     pos = 0 ;
       }
       else {
	  pos += 1 ;
       }
    }
    println!("{:?}" , trimmed ) ;
}
