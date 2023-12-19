use std::io ;

fn main() {
    println!("Enter a string and, separated by a blank, a letter from that string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let strings : Vec<&str> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( ) ).collect( ) ;
    let searchstring : &str = strings[0] ;
    let second_string : &str = strings[1] ;
    let mut chars = second_string.chars( ) ;
    let char_wanted = chars.next( ).unwrap( ) ;
    let mut character_pos : Vec<i16> = Vec::new( ) ;
    searchstring.chars( ).enumerate( ).filter( | el | el.1 == 
	  char_wanted ).for_each( | el | character_pos.push( el.0 as i16 ) ) ;
    let mut result : Vec<u16> = Vec::new( ) ;
    let mut pos : usize = 0 ;
    for c in searchstring.chars( ) {
       if c != char_wanted {
	  let min_distance = character_pos.iter( ).map( | n | (pos as i16).abs_diff(
		   *n as i16 )).min( ).unwrap( ) ;
	  result.push( min_distance ) ;
       }
       else {
	  result.push( 0u16 ) ;
       }
       pos += 1 ;
    }
    println!("{:?}" , result ) ;
}
