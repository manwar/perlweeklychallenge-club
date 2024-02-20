use std::io ;
use std::io::BufRead ;

fn has_leading_one( matrix : &Vec<Vec<i32>> ) -> bool {
   for row in matrix {
      let found : Option<i32> = row.iter( ).find( | x | **x != 0 ).copied( ) ;
      if  found.is_some( ) {
	 let num = found.unwrap( ) ;
	 if num != 1 {
	    return false ;
	 }
      }
   }
   true 
}

fn zeros_at_bottom( matrix : &Vec<Vec<i32>> ) -> bool {
   let enumerated_rows : Vec<(usize, &Vec<i32>)> = matrix.iter( ).
      enumerate( ).collect( ) ; 
   let mut all_zero_indices : Vec<usize> = Vec::new( ) ;
   let mut the_rest : Vec<usize> = Vec::new( ) ;
   for p in &enumerated_rows {
      if p.1.iter( ).all( | x | *x == 0 ) {
	 all_zero_indices.push( p.0 ) ;
      }
      else {
	 the_rest.push( p.0 ) ;
      }
   }
   let maximum = the_rest.iter( ).max().unwrap( ) ;
   all_zero_indices.iter( ).all( | d | *d > *maximum ) 
}

fn staggered_ones( matrix : &Vec<Vec<i32>> ) -> bool {
   let mut leading_ones : Vec<usize> = Vec::new( ) ;
   for row in matrix {
      let found : Option<i32> = row.iter( ).find( | x | **x != 0 ).copied( ) ;
      if found.is_some( ) {
	 let num = found.unwrap( ) ;
	 if num == 1 {
	    let pos = row.iter( ).position( | &x | x == 1 ).unwrap( ) ;
	    leading_ones.push( pos ) ;
	 }
      }
   }
   let len = leading_ones.len( ) ;
   if len == 0 || len == 1 {
      true
   }
   else {
      if len == 2 {
	 leading_ones[1] > leading_ones[0] 
      }
      else {
	 for i in 0..len - 1 {
	    if leading_ones[ i + 1 ] < leading_ones[ i ] {
	       return false ;
	    }
	 }
	 return true ;
      }
   }
}

fn all_zeroes_in_leading_one_column( matrix : &Vec<Vec<i32>> ) -> bool {
   let mut leading_one_positions : Vec<(usize, usize)> = Vec::new( ) ;
   let len = matrix.len( ) ;
   for i in 0..len {
      let row = &matrix[ i ] ;
      let found : Option<i32> = row.iter( ).find( |x| **x != 0 ).copied( ) ;
      if found.is_some( ) {
	 let num = found.unwrap( ) ;
	 if num == 1 {
	    let pos = row.iter( ).position( | x | *x == 1 ).unwrap( ) ;
	    leading_one_positions.push( (i , pos) ) ;
	 }
      }
   }
   leading_one_positions.iter( ).all( |(r , col)| {
	 for i in 0..len {
	    if i != *r {
	       return matrix[i][*col] == 0 ;
	    }
         }
	 false 
	 }) 
}
   
fn main() -> io::Result<()> {
    println!("Enter some integers, separated by blanks!");
    println!( "Enter <return> to end entry!" ) ;
    let mut lines = io::stdin( ).lock( ).lines( ) ;
    let mut all_input : String = String::new( ) ;
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
    let mut matrix : Vec<Vec<i32>> = Vec::new( ) ;
    let rows : Vec<&str> = all_input.split( "\n" ).collect( ) ;
    for r in &rows {
       if r.len( ) != 0 {
	  let numbers : Vec<i32> = r.split_whitespace( ).map( | s | 
		s.trim( ).parse::<i32>( ).unwrap( )).collect( ) ;
	  matrix.push( numbers ) ;
       }
    }
    if has_leading_one( &matrix ) && zeros_at_bottom( &matrix ) && 
       staggered_ones( &matrix ) && all_zeroes_in_leading_one_column( 
	     &matrix ) {
	  println!("1") ;
    }
    else {
       println!("0") ;
    }
    Ok(())
}
