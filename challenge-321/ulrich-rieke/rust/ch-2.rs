use std::io ;

fn reduce_str( word : &str ) -> String {
   let len : usize = word.chars( ).count( ) ;
   let mut my_word : String = word.into( ) ;
   while let Some( pos ) = my_word.find( "#" ) {
      let first_part : &str = &my_word[..pos - 1] ;
      if pos < len - 1 {
	 let second_part : &str = &my_word[pos + 1..] ;
	 let first_str : String = first_part.into( ) ;
	 my_word = first_str + second_part ;
      }
      else {
	 my_word = first_part.into( ) ;
      }
   }
   my_word 
}

fn main() {
    println!("Enter 2 words with zero or more #!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    println!("{}" , reduce_str( words[0] ) == reduce_str( words[1] ) ) ;
}
