use std::{io , cmp} ;
use std::io::BufRead ;

//find positions of all given letter in a block
fn find_positions( block : &Vec<&str> , letter : char) -> Vec<(usize , usize)> {
   let mut all_positions : Vec<(usize , usize)> = Vec::new( ) ;
   let len = block.len( ) ;
   for n in 0..len {
      let line : &str = &block[n] ;
      line.chars( ).enumerate( ).map( |tup| (n , tup.0 , tup.1 ) ).filter(
	    |&trip| trip.2 == letter ).map( |trip| (trip.0 , trip.1) ).for_each(
	     |tup| all_positions.push( tup ) ) ;
   }
  all_positions.sort_by( |a , b| {
	 if a.0 != b.0 {
	    a.0.cmp( &b.0 ) 
	 }
	 else {
	    a.1.cmp( &b.1 ) 
	 }}) ;
   all_positions 
}


//once we have created an ordered list of positions , we remove the first element
//from the list of positions and store it in another vector. Then, we keep removing
//all those elements from the ordered list of positions that are neighbouring
//to any of the elements removed. If we don't find any such element, we store
//the number of elements in a size vector and return, once all original elements
//are used up, the maximum of this list
fn find_contiguous_blocks( positions : &mut Vec<(usize , usize)> ) -> usize {
   let mut contiguous_blocksizes : Vec<usize> = Vec::new( ) ;
   let mut contiguous_blocks : Vec<(usize , usize)> = Vec::new( ) ;
   let pair : (usize , usize) = positions.remove( 0 ) ;
   contiguous_blocks.push( pair ) ;
   while positions.len( ) > 0 {
      while let Some( pos ) = positions.iter( ).position( |&p| {
	    contiguous_blocks.iter( ).any( | pa | is_neighbouring( *pa , p ) )
	    }) {
	    let elt : (usize , usize) = positions.remove( pos ) ;
	    contiguous_blocks.push( elt ) ;
      }
      contiguous_blocksizes.push( contiguous_blocks.len( ) ) ;
      contiguous_blocks.clear( ) ;
      if positions.len( ) > 0 {
	 let elt : (usize , usize ) = positions.remove( 0 ) ;
	 contiguous_blocks.push( elt ) ;
      }
   }
   contiguous_blocksizes.into_iter( ).max( ).unwrap( ) 
}

fn is_neighbouring( first_pair : (usize, usize) , second_pair : (usize, usize) ) 
   -> bool {
      (((first_pair.0 as i32) - ( second_pair.0 as i32)).abs( ) == 1 && 
	 first_pair.1 == second_pair.1) || ( first_pair.0 == second_pair.0 ) &&
	 (((first_pair.1 as i32) - (second_pair.1 as i32)).abs( ) == 1)
}

fn main() -> io::Result<( )> {
    println!("Enter some strings of equal length consisting of x and o!");
    println!("Enter <return> to end!" ) ;
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
    let valid_rows : Vec<&str> = rows.into_iter( ).filter( | &s |
     s.len( ) > 0 ).collect( ) ;
    let mut x_blocks : Vec<(usize , usize)> = find_positions( &valid_rows , 'x' ) ;
    let mut o_blocks : Vec<(usize , usize)> = find_positions( &valid_rows , 'o' ) ;
    let x_maxfield : usize = find_contiguous_blocks( &mut x_blocks ) ;
    let o_maxfield : usize = find_contiguous_blocks( &mut o_blocks ) ;
    println!("{}" , cmp::max( x_maxfield , o_maxfield ) ) ;
    Ok(()) 
}
