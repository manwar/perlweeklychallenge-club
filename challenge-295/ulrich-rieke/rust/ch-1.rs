use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Enter a long string!");
    let mut first_line : String = String::new( ) ;
    io::stdin( ).read_line( &mut first_line ).unwrap( ) ;
    println!("Enter a list of words separated by blanks!") ;
    let mut second_line : String = String::new( ) ;
    io::stdin( ).read_line(&mut second_line).unwrap( ) ;
    let words : Vec<&str> = second_line.split_whitespace( ).
       map( |s| s.trim( )).collect( ) ;
    if ! words.iter( ).all( |w| first_line.contains( &*w ) ) {
       println!("false") ;
    }
    else {
       let mut v : Vec<_> = Vec::new( ) ;
       for w in words {
	  let word_vector : Vec<_> = first_line.match_indices( w ).collect() ;
	  for p in word_vector {
	     v.push( p ) ;
	  }
       }
       let mut boundaries : Vec<Vec<usize>> = Vec::new( ) ;
       v.into_iter( ).map( |p| {
	     let mut range : Vec<usize> = Vec::new( ) ;
	     for i in p.0..p.0 + p.1.len( ) {
	       range.push( i ) ;
	     }
	     range 
	     } ).for_each( |r| boundaries.push( r ) ) ;
       let result : bool = {
	  let len = boundaries.len( ) ;
	  let mut pairresults : Vec<bool> = Vec::new( ) ;
	  for i in 0..len - 1 {
	     let mut first_set : HashSet<_> = HashSet::new( ) ;
	     let mut second_set : HashSet<_> = HashSet::new( ) ;
	     for num in &boundaries[ i ] {
		first_set.insert( num ) ;
	     }
	     for num in &boundaries[ i + 1] {
		second_set.insert( num ) ;
	     }
	     let common : HashSet<_> = &first_set & &second_set ;
	     pairresults.push( common.is_empty( ) ) ;
	  }
	  pairresults.into_iter( ).all( |t| t == true )  
       } ;
       println!("{}" , result) ;
    }
}
