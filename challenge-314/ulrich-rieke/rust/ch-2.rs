use std::io ;

fn is_sorted( word : &str ) -> bool {
   let mut original : Vec<char> = Vec::new( ) ;
   for c in word.chars( ) {
      original.push( c ) ;
   }
   let mut sorted : Vec<char> = original.clone( ) ;
   sorted.sort( ) ;
   original == sorted 
}

fn main() {
    println!("Enter some strings of same length separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let mut transposed : Vec<String> = Vec::new( ) ;
    let len : usize = words[0].chars( ).count( ) ;
    let wordslen = words.len( ) ;
    for i in 0..len {
       let mut transpo : String = String::new( ) ;
       for w in 0..wordslen {
	  let c : char = words[w].chars( ).nth( i ).unwrap( ) ;
	  transpo.push( c ) ;
       }
       transposed.push( transpo ) ;
    }
    let trans : Vec<&str> = transposed.iter( ).map( |string| 
	  string.as_str( ) ).collect( ) ;
    println!("{}" , trans.into_iter( ).filter( |s| ! is_sorted( s ) ).
	  count( ) ) ;
}
