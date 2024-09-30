use std::io ;
use std::io::BufRead ;
use rand::prelude::* ;

fn shuffle_in_between( word : &str ) -> String {
   let mut shuffled : String = String::new( ) ;
   shuffled.push( word.chars( ).nth( 0 ).unwrap( ) ) ;
   let mut rng = rand::thread_rng( ) ;
   let mut letters : Vec<char> = Vec::new( ) ;
   for n in 1..word.len( ) - 1 {
      letters.push( word.chars( ).nth( n ).unwrap( ) ) ;
   }
   letters.shuffle( &mut rng ) ;
   for l in letters {
      shuffled.push( l ) ;
   }
   shuffled.push( word.chars( ).last( ).unwrap( ) ) ;
   shuffled 
}

fn main() -> io::Result<( )> {
    println!("Enter some strings !");
    println!("Enter <return> to end!" ) ;
    let mut all_input : String = String::new( ) ;
    let mut lines = io::stdin( ).lock( ).lines( ) ;
    while let Some( line ) = lines.next( ) {
       let last_input = line.unwrap( ) ;
       if last_input.len( ) == 0 {
          break ;
       }
       else {
          all_input.push_str( &last_input ) ;
          all_input.push_str( "\n" ) ;
       }
    }
    let all_lines : &str = all_input.as_str( ).trim( ) ;
    let rows : Vec<&str> = all_lines.split( "\n").collect( ) ;
    let valid_rows : Vec<&str> = rows.into_iter( ).filter( |&s| s.len( )
	  > 0 ).collect( ) ;
    let mut shuffled_rows : Vec<Vec<String>> = Vec::new( ) ;
    for r in &valid_rows {
       let mut shuffled_words : Vec<String> = Vec::new( ) ;
       let words : Vec<&str> = r.split_whitespace( ).collect( ) ;
       for w in &words {
	  if w.len( ) > 3 {
	     let shuffled : String = shuffle_in_between( w ) ;
	     shuffled_words.push( shuffled ) ;
	  }
	  else {
	     shuffled_words.push( w.to_string( ) ) ;
	  }
       }
       shuffled_rows.push( shuffled_words ) ;
    }
    println!("{:?}" , shuffled_rows ) ;
    Ok(())
}
