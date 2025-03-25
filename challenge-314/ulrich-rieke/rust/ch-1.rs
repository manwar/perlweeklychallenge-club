use std::io ;

fn find_max_common_length( words : &Vec<&str> ) -> usize {
   let shortest : usize = words.iter( ).map( |s| s.chars( ).count( )).min()
      .unwrap( ) ;
   let mut allsubstrings : Vec<Vec<&str>> = Vec::new( ) ;
   for i in 1..=shortest {
      let substrings : Vec<&str> = words.iter( ).map( |s| &s[..i])
	 .collect( ) ;
      let comp : &str = substrings[0] ;
      if substrings.iter( ).all( |s| *s == comp ) {
	 allsubstrings.push( substrings ) ;
      }
   }
   allsubstrings.sort_by( |a , b| b[0].len( ).cmp( &a[0].len( ) )) ;
   allsubstrings[0][0].len( )
}

fn main() {
    println!("Enter 3 words separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let words : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let comp : char = words[0].chars( ).nth( 0 ).unwrap( ) ;
    if ! words.iter( ).all( |w| w.chars( ).nth( 0 ).unwrap( ) == comp ) {
       println!("{}" , -1) ;
    }
    else {
       let common_length : usize = find_max_common_length( &words ) ;
       println!("{}" , words.into_iter( ).map( |s| s.chars( ).count( ) - 
		common_length ).sum::<usize>( ) ) ;
    }
}
