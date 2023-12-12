use std::io ;
use std::collections::HashMap ;

fn main() {
    println!("Enter a string consisting of letters a-z");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut frequencies : HashMap<&str , u16> = HashMap::new( ) ;
    let len = inline.len( ) ;
    for k in 0..=len - 2 {
       let a_pair = &inline[k..k + 2] ;
       *frequencies.entry( a_pair ).or_insert( 1 ) += 1 ;
    }
    let mut the_pairs : Vec<(&str , u16)> = Vec::new( ) ;
    for ( key , value ) in frequencies.iter( ) {
       the_pairs.push( ( *key , *value ) ) ;
    }
    let pa_slice = the_pairs.as_mut_slice( ) ;
    pa_slice.sort_by( | a , b | {
	  if a.1 != b.1 {
	    b.1.cmp( &a.1 ) 
	  }
	  else {
	    a.0.cmp( &b.0 ) 
	  }
	  } ) ;
    println!("{:?}" , pa_slice[0].0 ) ;
}
