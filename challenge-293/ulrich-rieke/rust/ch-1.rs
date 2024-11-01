use std::io ;
use std::collections::HashSet ;
use std::io::BufRead ;

#[derive(Copy, Clone)]
struct Domino ( i32 , i32 ) ;

fn is_similar( first_dom : Domino , second_dom : Domino ) -> bool {
   (first_dom.0 == second_dom.0 && first_dom.1 == second_dom.1) || 
      (first_dom.0 == second_dom.1 && first_dom.1 == second_dom.0 ) 
}

fn main() -> io::Result<( )> {
    println!("Enter 2 integers, separated by blanks!");
    println!("Enter <return> to end entry!" ) ;
    let mut dominoes : Vec<Domino> = Vec::new( ) ;
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
    let domlines : Vec<&str> = all_lines.split( "\n" ).collect( ) ;
    domlines.into_iter( ).map( |s| {
	  let numbers : Vec<i32> = s.trim( ).split_whitespace( ).map( |d| 
		d.parse::<i32>( ).unwrap( ) ).collect( ) ;
	  let dom : Domino = Domino( numbers[0] , numbers[1] ) ;
	  dom 
	  } ).for_each( |d| dominoes.push( d ) ) ;
    let len = dominoes.len( ) ;
    let mut similars : HashSet<usize> = HashSet::new( ) ;
    for i in 0..len - 1 {
       for j in i + 1 .. len {
	  if is_similar( dominoes[i] , dominoes[j] ) {
	     similars.insert( i ) ;
	     similars.insert( j ) ;
	  }
       }
    }
    println!("{}" , similars.len( ) ) ;
    Ok(())
}
