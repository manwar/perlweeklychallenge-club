use std::io ;
use std::io::BufRead ;
use std::collections::HashSet ;

fn main() -> io::Result<()> {
    println!("Enter a n x n matrix containing integers from 1 to n!");
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
    let matrix_lines : Vec<&str> = all_input.trim( ).split( "\n").collect( ) ;
    let mut matrix : Vec<Vec<u16>> = Vec::new( ) ;
    matrix_lines.into_iter( ).map( |line| {
          let linenumbers : Vec<u16> = line.split_whitespace( ).map( |s| 
                s.parse::<u16>( ).unwrap( )).collect( ) ;
          linenumbers 
          }).for_each( |l| matrix.push( l.clone( ) ) ) ;
    let len : usize = matrix.len( ) ;
    let mut numberset : HashSet<u16> = HashSet::new( ) ;
    for i in 1usize..len + 1 {
       numberset.insert( i as u16 ) ;
    }
    let all_rows_ok : bool = matrix.iter( ).all( |r| {
          let mut row_set : HashSet<u16> = HashSet::new( ) ;
          for i in r {
            row_set.insert( *i ) ;
          }
          row_set == numberset 
          } ) ;
    let mut all_columns : Vec<Vec<u16>> = Vec::new( ) ;
    for col in 0..len {
       let mut column : Vec<u16> = Vec::new( ) ;
       for row in 0..len {
          column.push( matrix[row][col] ) ;
       }
       all_columns.push( column.clone( ) ) ;
    }
    let all_columns_ok = all_columns.into_iter( ).all( |c| {
          let mut col_set : HashSet<u16> = HashSet::new( ) ;
          for n in c {
            col_set.insert( n ) ;
          }
          col_set == numberset 
          }) ; 
    println!("{}" , all_rows_ok && all_columns_ok ) ;
    Ok(())
}
