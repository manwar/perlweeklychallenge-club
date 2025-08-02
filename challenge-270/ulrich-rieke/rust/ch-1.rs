use std::io ;
use std::cmp ;
use std::io::BufRead ;

fn main() ->io::Result<( )> {
    println!("Enter n row of m binary digits, separated by blanks!");
    println!("Enter <return> to end!") ;
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
    let all_lines : &str = all_input.as_str( ) ;
    let rows : Vec<&str> = all_lines.trim( ).split( "\n" ).collect( ) ;
    let mut matrix : Vec<Vec<u8>> = Vec::new( ) ;
    for r in &rows {
       if r.len( ) > 0 {
	  let row_nums : Vec<u8> = r.split_whitespace( ).map( | s | 
		s.trim( ).parse::<u8>( ).unwrap( ) ).collect( ) ;
	  matrix.push( row_nums ) ;
       }
    }
    let rownum : usize = matrix.len( ) ;
    let colnum : usize = matrix[0].len( ) ;
    let mut spec_rows : usize = 0 ;
    let mut spec_cols : usize = 0 ;
    for r in 0..rownum {
       if matrix[r].iter( ).sum::<u8>( ) == 1 {
	  spec_rows += 1 ;
       }
    }
    for c in 0..colnum {
       let mut transposed : Vec<u8> = Vec::new( ) ;
       for r in 0..rownum {
	  transposed.push( matrix[r][c] ) ;
       }
       if transposed.iter( ).sum::<u8>( ) == 1 {
	  spec_cols += 1 ;
       }
    }
    println!("{}" , cmp::min( spec_rows, spec_cols ) ) ;
    Ok(())
}

