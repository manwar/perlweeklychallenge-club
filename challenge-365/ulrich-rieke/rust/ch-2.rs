use std::io ;

fn is_valid( word : &str ) -> bool {
   let len : usize = word.chars( ).count( ) ;
   let mut result : Vec<bool> = Vec::new( ) ;
   result.push( word.chars( ).all( |c| ! c.is_digit( 10 ))) ;
   let condition2 : bool = match word.chars( ).position( |c| 
         c == '-' ) {
      Some( pos ) => pos != len - 1 && word.chars( ).filter( |&c| c == '-' )
         .count( ) == 1 && word.chars( ).nth( pos - 1 ).unwrap( ).
         is_ascii_alphabetic() && word.chars( ).nth( pos + 1 ).unwrap( ).
         is_ascii_alphabetic( ) ,
      None => true 
   } ;
   result.push( condition2 ) ;
   let condition3 : bool = if word.chars( ).filter( |&c| {
         let looked_for : &str = "!.," ;
         looked_for.contains( c ) 
         }).count( ) == 1 {
            word.chars( ).position( |c| c == '!' ||
            c == ',' || c == '.' ).unwrap( ) == word.chars( ).count( ) 
               - 1 
        }
        else {
           true 
        } ;
  result.push( condition3 ) ;
  result.into_iter( ).all( |c| c )
}

fn main() {
    println!("Enter a sentence!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let sentence : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    println!("{}" , sentence.into_iter( ).filter( |&s| is_valid( s )).
          count( ) ) ;
}
