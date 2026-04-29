fn find_missing( characters : Vec<char> ) -> char {
   use std::collections::HashSet ;
   let len : usize = characters.len( ) ;
   let mut differences : Vec<u32> = Vec::new( ) ;
   for i in 1..len {
      if characters[i] != '?' && characters[i - 1] != '?' {
         differences.push( characters[i] as u32 - characters[i -
                     1] as u32 )  ;
      }
   }
   let mut diff_set : HashSet<u32> = HashSet::new( ) ;
   for d in &differences {
      diff_set.insert( *d ) ;
   }
   let question_mark_pos : usize = characters.iter( ).position( |c| 
         *c == '?' ).unwrap( ) ;
   if diff_set.len( ) == 1 {
      if question_mark_pos == 0 {
         return char::from_u32( characters[1] as u32 - differences[0] ).unwrap( ) ;
      }
      else {
         return char::from_u32( characters[ question_mark_pos - 1] as u32 +
               differences[0]).unwrap( ) ;
      }
   }
   else {
      let mut newdiff : Vec<u32> = Vec::new( ) ;
      for _ in 0..2 { //create alternating differences
         newdiff.push( differences[0] ) ;
         newdiff.push( differences[1] ) ;
      }
      if question_mark_pos == 0 {
         return char::from_u32( characters[1] as u32 - newdiff[0]).unwrap( ) ;
      }
      else {
         return char::from_u32( characters[question_mark_pos - 1] as u32 + 
               newdiff[question_mark_pos - 1]).unwrap( ) ;
      }
   }
}

fn main( ) {
 println!("{}" , find_missing( vec!['a', 'c',  '?' ,  'g' ,  'i'] ));
 println!("{}" , find_missing( vec!['a', 'd',  '?' ,  'j' ,  'm'] ));
 println!("{}" , find_missing( vec!['a', 'e',  '?' ,  'm' ,  'q'] ));
 println!("{}" , find_missing( vec!['a', 'c',  'f' ,  '?' ,  'k'] ));
 println!("{}" , find_missing( vec!['b', 'e',  'g' ,  '?' ,  'l'] ));
}
