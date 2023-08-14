use std::io ;

fn is_sorted( word : &str ) -> bool {
   let mut letters : Vec<char> = Vec::new( ) ;
   for c in word.chars( ) {
      letters.push( c ) ;
   }
   let compare : Vec<char> = letters.clone( ) ;
   letters.sort( ) ;
   if letters == compare {
      return true ;
   }
   else {
      letters.reverse( ) ;
      if letters == compare {
	 return true ;
      }
      else {
	 return false ;
      }
   }
}

fn main() {
    println!("Enter some words, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    println!("{}" , entered_line.split_whitespace( ).filter( |&w| 
	     ! is_sorted( &w ) ).count( ) ) ; 
}
