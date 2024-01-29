use std::io ;
use std::io::BufRead ;

fn main() -> io::Result<()> {
    println!("Enter n rows of m binary digits, 1 before 0!");
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
    let rows : Vec<&str> = all_input.split( "\n").collect( ) ;
    let mut matrix : Vec<Vec<u8>> = Vec::new( ) ;
    for r in &rows {
       if r.len( ) > 0 { 
	  let row_nums : Vec<u8> = r.split_whitespace( ).map( | s | 
		s.trim( ).parse::<u8>( ).unwrap( ) ).collect( ) ;
	  matrix.push( row_nums ) ;
       }
    }
    let mut sorted_rows : Vec<(usize , &Vec<u8>)> = Vec::new( ) ;
    let mut iter = matrix.iter( ).enumerate( ) ;
    while let Some( pair ) = iter.next( ) {
       sorted_rows.push( pair ) ;
    }
    let for_sorting = sorted_rows.as_mut_slice( ) ;
    for_sorting.sort_by( | a , b| {
	  let ones_a = a.1.iter( ).filter( | d | **d == 1 ).count( ) ;
	  let ones_b = b.1.iter( ).filter( | d | **d == 1 ).count( ) ;
	  if ones_a != ones_b {
	   return ones_a.cmp( &ones_b ) ;
	  }
	  else {
	   return a.0.cmp( &b.0 ) ;
	  }
	  }) ;
    for pair in for_sorting {
       print!("{} " , pair.0 ) ;
    }
    println!("") ;
    Ok(())
}
