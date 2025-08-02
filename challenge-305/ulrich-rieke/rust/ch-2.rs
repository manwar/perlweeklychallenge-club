use std::io ;

fn main() {
    println!("Enter some words separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut words : Vec<&str> = inline.trim( ).split_whitespace( ).
       collect( ) ;
    println!("Enter a complete alfabet ! Separate letters by spaces!") ;
    let mut letterline : String = String::new( ) ;
    io::stdin( ).read_line( &mut letterline ).unwrap( ) ;
    let letters : Vec<char> = letterline.trim( ).split_whitespace( ).map( 
	  |s| s.chars( ).nth( 0 ).unwrap( ) ).collect( ) ;
    words.sort_by( |s1 , s2| {
	  if s1.starts_with( &*s2 ) {
	    s1.cmp( &s2 ) 
	   }
	   else {
	    if s2.starts_with( &*s1 ) {
	       s2.cmp( &s1 ) 
	    }
	    else {
	       let zipped : Vec<(char, char)> = s1.chars( ).zip( 
		     s2.chars( ) ).collect( ) ;
	       let mut i : usize = 0 ;
	       while zipped[i].0 == zipped[i].1 {
		  i += 1 ;
	       }
	       let first_pos : usize = letters.iter( ).position( |c|
		     *c == zipped[i].0 ).unwrap( ) ;
	       let second_pos : usize = letters.iter( ).position( |c|
		     *c == zipped[i].1 ).unwrap( ) ;
	       first_pos.cmp( &second_pos )
	    }
	  }
	  }) ;
    println!("{:?}" , words ) ;
}
