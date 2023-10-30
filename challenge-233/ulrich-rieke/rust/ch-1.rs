use std::io ;
use std::collections::{HashMap , HashSet} ;

fn pair_number( number : u32 ) -> u32 {
   let pairs : u32 = match number {
      inner if inner == 0 => 0 ,
      inner if inner == 1 => 0 , 
      inner if inner == 2 => 1 , 
      inner if inner > 2 => combinations( inner )  ,
                       _ => 0 ,
   } ;
   pairs 
}

fn combinations( num : u32 ) -> u32 {
   let mut numbers : Vec<u32> = Vec::new( ) ;
   for n in 1..=num {
      numbers.push( n ) ;
   }
   let numerator : u32 = numbers.iter( ).product( ) ;
   numbers.clear( ) ;
   for n in 1..=(num - 2 ) {
      numbers.push( n ) ;
   }
   let denom_fst : u32 = numbers.iter( ).product( ) ;
   numerator / ( denom_fst * 2 ) 
}

fn unique_letters( word : &str ) -> String {
   let mut letters : HashSet<char> = HashSet::new( ) ;
   for c in word.chars( ) {
      letters.insert( c ) ;
   }
   let mut final_string : String = String::new( ) ;
   let mut vec_letters : Vec<char> = Vec::new( ) ;
   for c in letters {
      vec_letters.push( c ) ;
   }
   vec_letters.sort( ) ;
   for c in vec_letters {
      final_string.push( c ) ;
   }
   final_string
}

fn main() {
    println!("Enter some words, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let words : Vec<&str> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( ) ).collect( ) ;
    let mut strings : Vec<String> = Vec::new( ) ;
    words.iter( ).map( | w | unique_letters( & w )).for_each( | res | 
	     strings.push( res ) ) ;
    let mut letter_combis : HashMap<String , u32> = HashMap::new( ) ;
    for s in &strings {
       let value = letter_combis.entry( s.to_string( ) ).or_default( ) ;
       *value += 1 ;
    }
    let mut pairs : u32 = 0 ;
    for (_ , v ) in letter_combis {
       pairs += pair_number( v ) ;
    }
    println!("{}" , pairs ) ;
}
