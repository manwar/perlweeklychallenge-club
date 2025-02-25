use std::io ;

fn main() {
    println!("Enter some words separated by whitespace!" );
    let mut wordline : String = String::new( ) ;
    io::stdin( ).read_line( &mut wordline ).unwrap( ) ;
    let words : Vec<&str> = wordline.trim( ).split_whitespace( ).collect( ) ;
    println!("Enter a sentence!" ) ;
    let mut sentence : String = String::new( ) ;
    io::stdin( ).read_line( &mut sentence ).unwrap( ) ;
    let trimmed : &str = sentence.as_str( ).trim( ) ;
    let sentencewords : Vec<&str> = trimmed.split_whitespace( ).
       collect( ) ;
    let mut changed_sentence : String = String::new( ) ;
    for s in &sentencewords {
       let mut changed : bool = false ;
       for w in &words {
	  if s.starts_with( w ) {
	     changed_sentence += w ;
	     changed = true ;
	  }
       }
       if ! changed {
	  changed_sentence += s ;
       }
       changed_sentence += " " ;
    }
    println!("{:?}" , changed_sentence.trim( ) ) ;
}

