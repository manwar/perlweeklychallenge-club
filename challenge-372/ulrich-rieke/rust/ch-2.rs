use std::io ;

fn find_distance( word : &str ) -> i8 {
   use std::collections::HashMap ;
   let mut frequencies : HashMap<char , usize> = HashMap::new( ) ;
   for c in word.chars( ) {
      *frequencies.entry( c ).or_insert( 1 ) += 1 ;
   }
   let most_frequent : Vec<char> = word.chars( ).filter( |&c| *frequencies.
         get( &c ).unwrap( ) > 1 ).collect( ) ;
   if most_frequent.len( ) == 0 {
       -1 
   }
   else {
      let letter_indices : Vec<(usize , char)> = word.char_indices( ).
         collect( ) ;
      let mut max_distance : i8 = 0 ;
      for c in most_frequent {
         let last_index : usize = letter_indices.iter( ).rposition( |d|
               d.1 == c).unwrap( ) ;
         let first_index : usize = letter_indices.iter( ).position( |d|
               d.1 == c ).unwrap( ) ;
         let distance : i8 = letter_indices[last_index].0 as i8 - 
               letter_indices[first_index].0 as i8 - 1i8 ;
         if distance > max_distance {
            max_distance = distance ;
         }
      }
      max_distance 
   }
}

fn main() {
    println!("Enter a string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let my_string : &str = inline.trim( ) ;
    println!("{}" , find_distance( my_string ) ) ;
}
