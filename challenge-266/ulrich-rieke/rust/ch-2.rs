use std::io;

fn enter_line( ) -> Vec<i32> {
   println!("Enter some integers ,separated by blanks!") ;
   let mut inline : String = String::new( ) ;
   io::stdin( ).read_line( &mut inline ).unwrap( ) ;
   let entered_line : &str = &*inline ;
   let numbers : Vec<i32> = entered_line.split_whitespace( ).map ( | s |
	 s.trim( ).parse::<i32>( ).unwrap( )).collect( ) ;
   numbers
}

fn is_diagonal( numbers : &Vec<Vec<i32>> ) -> bool {
   let len : usize = numbers.len( ) ;
   (0..len).all( | i | {
	 let row = &numbers[ i ] ;
	 row[ i ] != 0 
	 } )
}

fn is_antidiagonal( numbers : &Vec<Vec<i32>> ) -> bool {
   let len : usize = numbers.len( ) ;
   (0..len).all( | i | {
	 let row = &numbers[ i ] ;
	 row[len - 1 - i ] != 0 
	 } ) 
}

fn rest_zero( numbers : &Vec<Vec<i32>> ) -> bool {
   let len : usize = numbers.len( ) ;
   (0..len).all( | i | {
	 let row = &numbers[ i ] ;
	 for col in 0..len {
	    if i != col && i + col != len - 1 && row[ col ] != 0 {
	       return false ;
	    }
	 }
	 true 
	 } ) 
}
                     
fn main() {
   let mut matrix : Vec<Vec<i32>> = Vec::new ( ) ;
   let row : Vec<i32> = enter_line( ) ;
   let len : usize = row.len( ) ;
   matrix.push( row ) ;
   for _ in 0..len - 1 { // this guarantees input of a square matrix
      let new_row : Vec<i32> = enter_line( ) ;
      matrix.push( new_row ) ;
   }
   if is_diagonal( &matrix ) && is_antidiagonal( &matrix ) && rest_zero( 
	 &matrix ) {
      println!( "true" ) ;
   }
   else {
      println!("false") ;
   }
}
