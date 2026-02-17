use std::io ;
use std::io::BufRead ;

fn main() -> io::Result<()> {
    println!("Enter some lines with 0 or 1 , <enter> to end!");
    let mut all_input : String = String::new( ) ;
    let mut lines = io::stdin( ).lock( ).lines( ) ;
    while let Some( line ) = lines.next( ) {
       let last_input = line.unwrap( ) ;
       if last_input.len( ) == 0 {
          break ;
       }
       else {
          all_input.push_str( &last_input ) ;
          all_input.push( '\n' ) ;
       }
    }
    let all_lines : Vec<&str> = all_input.trim( ).split( "\n" ).collect( ) ;
    let mut matrix : Vec<Vec<u8>> = Vec::new( ) ;
    all_lines.into_iter( ).map( |s| {
          let wordrow : Vec<&str> = s.split_whitespace( ).collect( ) ;
          let row : Vec<u8> = wordrow.into_iter( ).map( |w| w.parse::<u8>().
                unwrap( )).collect( ) ;
          row
          }).for_each( |r| matrix.push( r.clone( ) )) ;
    let mut result : i8 = 0 ;
    let zero_only : usize = matrix.iter( ).filter( |&r| r.iter( ).all( |n|
             *n == 0 )).count( ) ;
    if zero_only != 1 {
       result = -1 ;
    }
    else {
       let pos : usize = matrix.iter( ).position( |r| r.iter( ).all( |n| 
                *n == 0 )).unwrap( ) ;
       for r in 0..matrix.len( ) {
          if r != pos && matrix[r][pos] != 1 {
             result = -1 ;
             break ;
          }
          result = pos as i8 ;
       }
    }
    println!("{}" , result ) ;
    Ok(())
}
