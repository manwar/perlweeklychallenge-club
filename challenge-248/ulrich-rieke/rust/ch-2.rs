use std::io ;
use std::io::BufRead ;

fn main() -> io::Result<( )> {
   println!("Please enter integers as rows of a matrix, separated by blanks!") ;
   println!("Enter <return> to end!" ) ;
   let mut lines = io::stdin( ).lock( ).lines( ) ;
   let mut user_input = String::new( ) ;
   while let Some( line ) = lines.next( ) {
      let last_input = line.unwrap( ) ;
      if last_input.len( ) == 0 {
         break ;
      }
      else {
         user_input.push_str("\n" ) ;
      }
      user_input.push_str( &last_input ) ;
   }
   let all_rows : Vec<&str> = user_input.split( "\n" ).collect( ) ;
   let mut matrix : Vec<Vec<i32>> = Vec::new( ) ;
   for a_row in &all_rows {
      if a_row.len( ) > 0 {
	 let number_row : Vec<i32> = a_row.split_whitespace( ).map( | s | 
	       s.trim( ).parse::<i32>( ).unwrap( )).collect( ) ;
	 matrix.push( number_row ) ;
      }
   } 
   let matrix_len : usize = matrix.len( ) ;
   let row_len : usize = matrix[0].len( ) ;
   let mut result : Vec<Vec<i32>> = Vec::new( ) ;
   for r in 0..matrix_len - 1 {
      let mut result_line : Vec<i32> = Vec::new( ) ;
     for col in 0..row_len - 1 {
	 let sum = matrix[r][col] + matrix[r][col + 1] + matrix[r + 1][col] +
	    matrix[r + 1][col + 1] ;
	 result_line.push( sum ) ;
      }
      result.push( result_line ) ;
   }
   println!("{:?}" , result ) ;
   Ok(()) 
}
