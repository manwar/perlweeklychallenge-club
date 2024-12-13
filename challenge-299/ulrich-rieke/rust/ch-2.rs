use std::io ;
use std::collections::{HashMap , HashSet} ;
use std::io::BufRead ;

fn is_neighbouring( first_pair : &(usize , usize) , second_pair : 
      &(usize , usize ) ) -> bool {
   (first_pair.0 == second_pair.0 && (first_pair.1 as i32).abs_diff( 
     second_pair.1 as i32) == 1 ) ||
   ((first_pair.0 as i32).abs_diff(second_pair.0 as i32) == 1 && 
   first_pair.1 == second_pair.1) 
}

fn condition( positions_so_far : &Vec<(usize , usize)> ) -> bool {
    let len = positions_so_far.len( ) ;
    let all_unique : bool = { 
       let mut positions : HashSet<(usize, usize)> = HashSet::new( ) ;
       for p in positions_so_far {
	  positions.insert( *p ) ;
       }
       len == positions.len( ) 
    } ;
    if len == 1 {
       true
    } 
    else {
       let second_cond : bool = {
	  let pairslice = &positions_so_far[..] ;
	  pairslice.windows( 2 ).all( |pa| is_neighbouring(&pa[0] , 
		   &pa[1] ) ) 
       } ;
       all_unique && second_cond 
    }
}
    
fn main() -> io::Result<()> {
    println!("Enter a string!") ;
    let mut comparator : String = String::new( ) ;
    io::stdin( ).read_line( &mut comparator).unwrap( ) ;
    let comp : String = comparator.trim( ).to_string( ) ;
    println!("Enter some characters separated by whitespace!");
    println!("Enter <return> to end!") ;
    let mut all_input : String = String::new( ) ;
    let mut lines = io::stdin( ).lock( ).lines( ) ;
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
    let all_lines : &str = all_input.as_str( ).trim( ) ;
    let rows : Vec<&str> = all_lines.split( "\n" ).collect( ) ;
    let valid_rows : Vec<&str> = rows.into_iter( ).filter( |&s| 
	  s.len( ) > 0 ).collect( ) ;
    let mut all_chars : Vec<Vec<char>> = Vec::new( ) ;
    valid_rows.into_iter( ).map( |line| {
	  let mut the_chars : Vec<char> = Vec::new( ) ;
	  line.split_whitespace( ).map( |s| s.chars( ).nth(0).unwrap( ) ).
	  for_each( |c| the_chars.push( c ) ) ;
	  the_chars.clone( ) } ).for_each( |v| all_chars.push( v ) ) ;
    //if there are more letters in the string than in the character array
    //the output is "false"
    let letternum : usize = all_chars.len( ) * all_chars[0].len( ) ;
    if comp.len( ) > letternum {
       println!("false" ) ;
    }
    else {
       //if any of the letters in the string does not occur in the letter
       //array the output is "false"
       if comp.as_str( ).chars( ).any( |c| {
	     let mut characters : HashSet<char> = HashSet::new( ) ;
	     for vec in &all_chars {
	       for c in *&vec {
		  characters.insert( *c ) ;
	       }
	     }
	     ! characters.contains( &c ) 
	     }) {
	  println!("false") ;
       }
       else {
	  //does the string we provided equal one of the rows or 
	  //columns of the character array ?
	  let mut rows : Vec<String> = Vec::new( ) ;
	  let mut columns : Vec<String> = Vec::new( ) ;
	  for r in &all_chars {
	     let mut word : String = String::new( ) ;
	     for c in r {
		word.push( *c ) ;
	     }
	     rows.push( word.clone( ) ) ;
	  }
	  for l in 0..all_chars[0].len( ) {
	     let mut word : String = String::new( ) ;
	     for r in 0..all_chars.len( ) {
		word.push( all_chars[r][l] ) ;
	     }
	     columns.push( word.clone( ) ) ;
	  }
	  let mut reversed : String = String::new( ) ;
	  for c in comp.chars().rev( ) {
	     reversed.push( c ) ;
	  }
	  if rows.contains( &comp ) || columns.contains( &comp ) || 
	   rows.contains( &reversed ) || columns.contains( &reversed ) {
	     println!("true") ;
	  }
	  else {
	     //create a hashmap of all the positions of every letter in
	     //the letter array
	     let mut positions : HashMap<char , Vec<Vec<(usize , usize)>>>
		= HashMap::new( ) ;
	     for r in 0..all_chars.len( ) {
		for c in 0..all_chars[0].len( ) {
		   let l = all_chars[r][c] ;
		   positions.entry( l ).and_modify( |vec|
			 vec.push(vec![(r , c)])).or_insert(
			 vec![vec![(r , c)]] ) ;
		}
	     }
	     let mut sequences : Vec<Vec<(usize, usize)>> =
		Vec::new( ) ;
	     //if there is only one letter in the string see if it 
	     //occurs in the array
	     //otherwise , select all combinations of two subsequent 
	     //letters that are neighbouring to each other
	     //for every next character , see if we can find a position
	     //of that character that fulfils the following conditions:
	     //a) it is neighbouring to the last character
	     //b) it wasn't used yet
	     if comp.len( ) == 1 {
		let letter = comp.as_str( ).chars( ).nth( 0 ).unwrap( ) ;
		if positions.contains_key( &letter ) {
		   println!("true") ;
		}
		else {
		   println!("false") ;
		}
	     }
	     else {
//when we add a new character we combine the positions of the new character
		//with all those of the previous one ; then we weed out
		//those that do not fulfil the above condition
		let compstr = comp.as_str( ) ;
		for c in compstr.chars( ) {
		   let letterpositions : Vec<Vec<(usize , usize)>> = 
		      positions.get( &c).unwrap( ).clone( ) ;
		   if sequences.is_empty( ) {
		      for p in letterpositions {
			 sequences.push( p.clone( ) ) ;
		      }
		   }
		   else {
		      let mut combis : Vec<Vec<(usize, usize)>> =
			 Vec::new( ) ;
		      for posi in sequences.iter_mut( ) {
			 for p in &letterpositions {
			    posi.push( p[0] ) ;
			    let a_vec = posi.clone( ) ;
			    combis.push( a_vec) ;
			    posi.pop( ) ;
			 }
		      }
		      sequences = combis ;
		      let selected : Vec<Vec<(usize, usize)>> = 
			 sequences.into_iter( ).filter( |v| 
			       condition( &v ) ).collect( ) ;
		      sequences = selected ;
		   }
		}
		if sequences.into_iter( ).any( |v| v.len( ) == 
		      compstr.chars( ).count( ) ) {
		   println!("true") ;
		}
		else {
		   println!("false") ;
		}
	     }
	  }
       }
    }
    Ok(())
}
