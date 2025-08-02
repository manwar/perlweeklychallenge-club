use std::io ;

fn convert( element : (usize , &str) ) -> String {
   let vowels : Vec<char> = vec!['A' , 'E' , 'I' , 'O' , 'U' , 'a' , 'e' , 'i' , 
       'o' , 'u'] ;
   let vows = &vowels[..] ;
   let word : &str = element.1 ;
   let first_letter : char = word.chars( ).nth( 0 ).unwrap( ) ;
   let mut changed : String = String::new( ) ;
   if vows.contains( &first_letter ) {
      for c in word.chars( ) {
	 changed.push( c ) ;
      }
   }
   else {
      for c in word.chars( ).skip( 1 ) {
	 changed.push( c ) ;
      }
      changed.push( first_letter ) ;
   }
   changed.push_str( "ma" ) ;
   let added : String = "a".repeat( element.0 + 1 ) ;
   changed.push_str( &added ) ;
   changed 
}

fn main() {
    println!("Enter a sentence!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let words : Vec<&str> = entered_line.split_whitespace( ).collect( ) ;
    let mut goated : Vec<String> = Vec::new( ) ;
    words.into_iter( ).enumerate( ).for_each( | p | goated.push( convert( p ) ) ) ;
    let mut final_string : String = String::new( ) ;
    final_string.push_str( goated[0].as_str( ) ) ;
    final_string.push_str( " " ) ;
    for i in 1..goated.len( ) {
       final_string.push_str( &goated[i] ) ;
       if i < goated.len( ) - 1 {
	  final_string.push_str( " " ) ;
       }
    }
    println!( "{:?}" , final_string) ;
}
