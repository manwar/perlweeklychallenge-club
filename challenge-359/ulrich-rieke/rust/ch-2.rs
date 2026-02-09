fn remove_double_letters( word : &str ) -> String {
   let mut characters : Vec<char> = Vec::new( ) ;
   for c in word.chars( ) {
      characters.push( c ) ;
   }
   let mut len : usize = characters.len( ) ;
   while let Some( pos ) = (0..len - 1).position( |i| 
         characters[i] == characters[i + 1] )  {
      characters.remove( pos ) ;
      characters.remove( pos ) ;
      len = characters.len( ) ;
      if len == 0 {
         break ;
      }
   }
   let mut reduced : String = String::new( ) ;
   if ! characters.is_empty( ) {
      characters.into_iter( ).for_each( |c| reduced.push( c ) ) ;
   }
   reduced 
}

fn main() {
   use std::io ;
    println!("Enter a word consisting of alphabetic characters only!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let word = inline.trim_end( ) ;
    println!("{:?}" , remove_double_letters( word ) ) ;
}
