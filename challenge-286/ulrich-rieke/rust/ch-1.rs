use std::io::{self , BufRead , BufReader} ;
use std::fs::File ;
use rand ; 

fn main() -> io::Result<()>{
   let path = "main.rs" ;
   let source_file = File::open( path )? ;
   let reader = BufReader::new( source_file ) ;
   let mut all_words : Vec<String> = Vec::new( ) ;
   for line in reader.lines( ) {
      let codeline = line.unwrap( ) ;
      if codeline.len( ) > 0 {
	 let codewords : &str = codeline.as_str( ) ;
	 codewords.split_whitespace( ).for_each( | s | {
	       let str = s.into( ) ;
	       all_words.push( str )  ;
	   } ) ; 
      }
   }
   let len = all_words.len( ) ;
   let selected : u32 = rand::random::<u32>( ) ;
   let select_pos : usize = (selected as usize) % len ;
   println!("{:?}" , all_words[select_pos] ) ;
   Ok(() ) 
}
