use std::io::BufRead ;
use std::{io , cmp} ;

fn find_squares (matrix : &Vec<Vec<u8>> , row : usize , col : usize ) ->
 Vec<Vec<u8>> {
    let mini = cmp::min(matrix.len( ) - row , matrix[0].len( ) - col ) ;
    let mut all_squares : Vec<Vec<u8>> = Vec::new( ) ;
    for i in 0..mini {
       let mut small_square : Vec<u8> = Vec::new( ) ;
       if i == 0 {
	  small_square.push( matrix[row][col] ) ;
	  all_squares.push( small_square ) ;
       }
       else {
	  for r in row..=row + i {
	     for c in col..=col + i {
		small_square.push( matrix[r][c] ) ;
	     }
	  }
	  all_squares.push( small_square ) ;
       }
    }
    all_squares 
 }

fn find_square_sum ( matrix : &Vec<Vec<u8>> , row : usize , col : usize ) -> usize {
   let result : Vec<Vec<u8>> = find_squares( &matrix , row , col ) ;
   let mut sizes : Vec<usize> = Vec::new( ) ;
   result.iter( ).map( |v| {
	 if v.iter( ).all( |d| *d == 1 ) {
	    v.iter( ).sum( ) 
	 }
	 else {
	    0 
	 }
	 }).for_each( |val| sizes.push( val as usize ) ) ;
   if  sizes.len( ) > 0 {
      sizes.into_iter( ).max( ).unwrap( ) 
   }
   else {
      0 
   }
}

fn main() -> io::Result<( )> {
    println!("Enter some 0 and 1 separated by whitespace!");
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
    let rows : Vec<&str> = all_lines.split( "\n").collect( ) ;
    let valid_rows : Vec<&str> = rows.into_iter( ).filter( |&s| s.len( )
          > 0 ).collect( ) ;
    let mut matrix : Vec<Vec<u8>> = Vec::new( ) ;
    for v in valid_rows {
       let row : Vec<u8> = v.chars( ).filter_map( |c| {
	     if c.is_digit( 10 ) {
	       Some( c.to_digit( 10 ).unwrap( ) as u8 )
	     }
	     else {
	       None 
	    }
	    }).collect( ) ;
       matrix.push( row ) ;
    }
    let matrix_len : usize = matrix.len( ) ;
    let row_len : usize = matrix[0].len( ) ;
    let mut squaresizes : Vec<usize> = Vec::new( ) ;
    for r in 0..matrix_len - 1 {
       for c in 0..row_len {
	  let the_sum : usize = find_square_sum( &matrix , r , c ) ;
	  squaresizes.push( the_sum ) ;
       }
    }
    if squaresizes.len( ) == 0 {
       println!("0") ;
    }
    else {
       println!("{}" , squaresizes.into_iter( ).max( ).unwrap( ) ) ;
    }
    Ok(())
}
