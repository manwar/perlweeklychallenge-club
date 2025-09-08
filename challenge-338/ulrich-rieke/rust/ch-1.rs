use std::io ;
use std::io::BufRead ;

fn main() -> io::Result<( )> {
    println!("Enter some lines of integers , separated by blanks!");
    println!("Enter <return> to end entry!" ) ;
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
    let total_line : &str = all_input.as_str( ).trim( ) ;
    let all_lines : Vec<&str> = total_line.split( "\n" ).collect( ) ;
    let mut matrix : Vec<Vec<i32>> = Vec::new( ) ;
    for s in &all_lines {
       let row : Vec<i32> = s.split_whitespace( ).map( |l| l.parse::<i32>( ).unwrap( )).
	  collect( ) ;
       matrix.push( row.clone( ) ) ;
    }
    let mut rowsums : Vec<i32> = Vec::new( ) ;
    matrix.into_iter( ).map( |r| r.iter( ).sum( )).for_each( |d| rowsums.push( d ) ) ;
    println!("{}" , rowsums.into_iter( ).max( ).unwrap( ) ) ;
    Ok(())
}
