use std::io ;
use std::collections::HashMap ;

fn count_letters( stri : &str ) -> HashMap<char, usize> {
   let mut lettercount = HashMap::new( ) ;
   for c in stri.chars( ) {
      lettercount.entry( c ).and_modify( | counter | *counter += 1 ).
	 or_insert( 1 ) ;
   }
   lettercount 
}

fn main() {
    println!("Enter an alphanumeric string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    println!("Enter some alphabetic strings, separated by blanks!") ;
    let mut secline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secline ).unwrap( ) ;
    let strings_line : &str = &*secline ;
    let mut all_lower : String = String::new( ) ;
    for c in entered_line.trim( ).chars( ) {
       if c.is_ascii_alphabetic( ) {
	  if c.is_ascii_uppercase( ) {
	     all_lower.push( c.to_ascii_lowercase( ) ) ;
	  }
	  else {
	     all_lower.push( c ) ;
	  }
       }
    }
    let words : Vec<&str> = strings_line.split_whitespace( ).map( | s | 
	  s.trim( ) ).collect( ) ;
    let all_the_lower : &str = all_lower.as_str( ) ;
    let target_hash = count_letters( all_the_lower ) ;
    let mut selected : Vec<&str> = words.into_iter().filter( | s | {
	  let hm = count_letters( s ) ;
	  target_hash.keys( ).all( | k | hm.get( &k ).is_some( ) && 
		hm.get( &k ).unwrap( ) >= target_hash.get( &k ).unwrap( ))
		}).collect( ) ;
    selected.sort_by_key( | s | s.chars( ).count( ) ) ;
    if selected.len( ) > 0 {
       println!("{:?}" , selected[0] ) ;
    }
    else {
       println!(" ") ;
    }
}
