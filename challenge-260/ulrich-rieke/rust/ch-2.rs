use std::io ;
use itertools::Itertools ;

fn to_string( all_chars : &Vec<char> ) -> String {
   let mut output : String = String::new( ) ;
   for c in all_chars {
      output.push( *c ) ;
   }
   output
}

fn main() {
    println!("Enter a word, preferably in capital letters only!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut letters : Vec<char> = Vec::new( ) ;
    let changed = entered_line.trim( ) ;
    let compared_to = changed.to_string( ) ;
    for c in changed.chars( ) {
       letters.push( c ) ;
    }
    let len : usize = letters.len( ) ;
    let mut all_permu : Vec<String> = Vec::new( ) ;
    for ve in  letters.into_iter().permutations( len ) {
       let word : String = to_string( &ve ) ;
       let found = all_permu.iter( ).find( | &st | *st == word ) ;
       if found.is_none( ) {
	  all_permu.push( word ) ;
       }
    }
    all_permu.sort( ) ;
    println!("{}" , all_permu.iter( ).position( | w | *w ==
	     compared_to  ).unwrap( ) + 1) ;
}
