use std::io ;
use std::collections::HashMap ;
use std::io::BufRead ;

fn are_similar( first_list : &Vec<&str> , second_list : &Vec<&str> , 
      similarities : &HashMap<&str , Vec<&str>> ) -> bool {
   if first_list.len( ) != second_list.len( ) {
      false 
   }
   else {
      let l : usize = first_list.len( ) ;
      let mut indices : Vec<usize> = Vec::new( ) ;
      for i in 0..l {
         indices.push( i ) ;
      }
      let selected : Vec<usize> = indices.into_iter( ).filter( |&n| 
            first_list[n] != second_list[n] ).collect( ) ;
      if selected.len( ) == 0 {
         true 
      }
      else {
         selected.into_iter( ).all( |n| {
               match similarities.get( &first_list[n] ) {
                  Some( sublist ) => sublist.into_iter( ).position( |s| 
                        *s == second_list[n] ).is_some( ) , 
                  None => false 
              } 
              } )
      }
   }
}



fn main( ) -> io::Result<()> {
   println!("Enter a first list , separating words by blanks!" ) ;
   let mut first_line : String = String::new( ) ;
   io::stdin( ).read_line( &mut first_line ).unwrap( ) ;
   let first_words : Vec<&str> = first_line.trim( ).split_whitespace( ).
      collect( ) ;
   println!("Enter a second list, separating words by blanks!" ) ;
   let mut second_line : String = String::new( ) ;
   io::stdin( ).read_line( &mut second_line ).unwrap( ) ;
   let second_words : Vec<&str> = second_line.trim( ).split_whitespace( ).
      collect( ) ;
   println!( "Enter a list of lists , separating words by blanks!") ;
   println!("Enter <newline> to end entry!" ) ;
   let mut all_input : String = String::new( ) ;
   let mut lines = io::stdin( ).lock( ).lines( ) ;
   while let Some( line ) = lines.next( ) {
      let last_input = line.unwrap( ) ;
      if last_input.len( ) == 0 {
         break ;
      }
      else {
         all_input.push_str( &last_input ) ;
         all_input.push( '\n' ) ;
      }
   }
   let all_lines : Vec<&str> = all_input.trim( ).split( "\n").collect( ) ;
   let mut similarity_vec : Vec<Vec<&str>> = Vec::new( ) ;
   all_lines.into_iter( ).map( |s| {
         let entry_row : Vec<&str> = s.split_whitespace( ).collect( ) ;
         entry_row 
         }).for_each( |v| similarity_vec.push( v.clone( ) )) ;
   let mut similarities : HashMap<&str , Vec<&str>> = HashMap::new( ) ;
   similarity_vec.into_iter( ).map( |v| (v[0] , v.into_iter( ).skip( 1 ).collect::
            <Vec<&str>>() ) ).
      for_each( |p| {
            similarities.insert( p.0 , p.1.clone( )) ;
            }) ;
   let result : bool = are_similar( &first_words , &second_words , &similarities ) 
      || are_similar( &second_words, &first_words , &similarities ) ;
   println!("{}" , result ) ;
   Ok(())
}
