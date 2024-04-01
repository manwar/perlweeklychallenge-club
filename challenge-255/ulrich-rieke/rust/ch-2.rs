use std::io ;
use std::io::BufRead ;
use std::collections::HashMap ;

fn main() -> io::Result<()> {
    println!( "Enter a banned word in the paragraph!" ) ;
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_word : &str = &*inline ;
    let changed = entered_word.trim( ) ;
    println!("Enter a paragraph of text, <return> to end entry!");
    let mut lines = io::stdin( ).lock( ).lines( ) ;
    let mut all_input : String = String::new( ) ;
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
    let rows : Vec<&str> = all_input.split( "\n" ).collect( ) ;
    let mut frequencies : HashMap<&str, usize> = HashMap::new( ) ;
    for r in & rows {
       if r.len( ) != 0 {
	  let words : Vec<&str> = r.split_whitespace( ).map( | s | 
		s.trim( ) ).collect( ) ;
	  for w in & words {
	     let wo = w.trim_end_matches( | c : char |
		   ! c.is_ascii_alphabetic( ) ) ;
	     frequencies.entry( &*wo ).and_modify ( | s | *s += 1).
		or_insert( 1 ) ;
	  }
       }
    }
    let mut all_words : Vec<(&str, usize)> = Vec::new( ) ;
    for ( key , val ) in frequencies.iter( ) {
       all_words.push( ( key , *val ) ) ;
    }
    let the_words = &mut all_words[..] ;
    the_words.sort_by( | a , b | b.1.cmp( &a.1 ) ) ;
    let chosen_word = the_words.first( ).unwrap( ) ;
    if chosen_word.0 != changed {
       println!("{:?}" , chosen_word ) ;
    }
    else {
       let mut iter = the_words.iter( ).skip( 1 ) ;
       match iter.next( ) {
	  Some ( pair ) => println!("{:?}" , pair.0 ) ,
	       None    => println!("") ,
       } ;
    }
    Ok(())
}
