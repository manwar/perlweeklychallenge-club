use std::io ;
use std::collections::HashMap ;

fn is_ascending( positions : &Vec<usize> ) -> bool {
   let mut result : bool = true ;
   let len = positions.len( ) ;
   for i in 0..len - 1 {
      if positions[i + 1] - positions[i] != 1 {
	 result = false ;
	 break ;
      }
   }
   result 
}

fn main() {
    println!("Enter a word!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let word : &str = inline.trim( ) ;
    let pairs : Vec<(usize, char)> = word.chars( ).enumerate( ).collect( ) ;
    let mut positions : HashMap<char, Vec<usize>> = HashMap::new( ) ;
    for ( n , c ) in pairs {
       positions.entry( c ).and_modify( |v| v.push(n) ).or_insert( 
	     vec![n] ) ;
    }
    let mut solution : Vec<String> = Vec::new( ) ;
    let mut all_keys : Vec<&char> = positions.keys( ).collect( ) ;
    all_keys.sort( ) ;
    for k in all_keys {
       let v = positions.get( &*k ).unwrap( ) ;
       if v.len( ) >= 3 && is_ascending( &v ) {
	  let mut a_word : String = String::new( ) ;
	  for _ in 0..v.len( ) {
	     a_word.push( *k ) ;
	  }
	  solution.push( a_word.clone( ) ) ;
       }
    }
    if solution.len( ) > 0 {
       println!("{:?}" , solution ) ;
    }
    else {
       println!("\"\"") ;
    }
}
