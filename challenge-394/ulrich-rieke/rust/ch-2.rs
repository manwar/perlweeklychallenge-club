use std::io ;
use std::collections::HashSet ;

fn is_alternating( word : &str ) -> bool {
   let vowels : Vec<char> = vec!['a' , 'e' , 'i' , 'o' , 'u'] ;
   let letterpositions : Vec<(usize, char)> = word.char_indices( ).
      collect( ) ;
   let startletter : char = word.chars( ).nth( 0 ).unwrap( ) ;
   if vowels.contains( &startletter ) {
      letterpositions.iter( ).all( |p| {
            if p.0 % 2 == 0 {
               vowels.contains( &p.1 ) 
            }
            else {
               ! vowels.contains( &p.1 ) 
           }
           } )
   }
   else {
      letterpositions.iter( ).all( |p| {
            if p.0 % 2 == 0 {
               ! vowels.contains( &p.1 ) 
            }
            else {
               vowels.contains( &p.1 ) 
            }
            } ) 
   }
}

fn all_substrings( word : &String ) -> Vec<&str> {
   let len : usize = word.len( ) ;
   let mut substrings : Vec<&str> = Vec::new( ) ;
   for start in 0..len {
      for end in start + 1..len + 1{
         substrings.push( &word[start..end] ) ;
      }
   }
   substrings 
}


fn main() {
    println!("Enter three strings with English alphabetic characters!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let f = entered[0].into( ) ;
    let s = entered[1].into( ) ;
    let t = entered[2].into( ) ;
    let first_strings : Vec<&str> = all_substrings( &f ) ;
    let second_strings : Vec<&str> = all_substrings( &s ) ;
    let third_strings : Vec<&str> = all_substrings( &t ) ;
    let mut first_set : HashSet<&str> = HashSet::new( ) ;
    let mut second_set : HashSet<&str> = HashSet::new( ) ;
    let mut third_set : HashSet<&str> = HashSet::new( ) ;
    for s in first_strings {
       first_set.insert( s ) ;
    }
    for s in second_strings {
       second_set.insert( s ) ;
    }
    for s in third_strings {
       third_set.insert( s ) ;
    }
    let all_sets : Vec<HashSet<&str>> = vec![first_set , second_set , third_set] ;
    let find_common = | com , current | {
       &com & &current 
    } ;
    let common : HashSet<&str> = all_sets.into_iter( ).reduce( find_common ).
       expect( "Finding a common string failed!" ) ;
    let mut selection : Vec<&str> = Vec::new( ) ;
    common.iter( ).filter( |&s| is_alternating( s ) ).for_each( |s|
          selection.push( s ) ) ;
    if common.len( ) > 0 {
       selection.sort_by_key( |s| s.chars( ).count( ) ) ;
       let last : &str = selection[selection.len( ) - 1]  ;
       println!("{:?}" , selection.into_iter( ).filter( |&s| s.chars( ).count( ) ==
                last.chars( ).count( )).collect::<Vec<&str>>( ) ) ;
    }
    else {
       println!("()") ;
    }
}
