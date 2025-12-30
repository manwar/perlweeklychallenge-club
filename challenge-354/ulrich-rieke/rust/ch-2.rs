use std::io ;
use std::io::BufRead ;

fn shift_once( grid : & Vec<Vec<u16>> ) -> Vec<Vec<u16>> {
   let mut linear_vec : Vec<u16> = Vec::new( ) ;
   let rows : usize = grid.len( ) ;
   let columns : usize = grid[0].len( ) ;
   for r in 0..rows {
       for c in 0..columns {
           linear_vec.push( grid[r][c] ) ;
       }
   }
   let mut shifted : Vec<u16> = Vec::new( ) ;
   let total_elements : usize = linear_vec.len( ) ;
   shifted.push( linear_vec[total_elements - 1] ) ;
   for i in 0..total_elements - 1 {
       shifted.push( linear_vec[i] ) ;
   }
   let shift_slice = shifted.as_slice( ) ;
   let result : Vec<&[u16]> = shift_slice.chunks( columns ).collect( ) ;
   let mut final_result : Vec<Vec<u16>> = Vec::new( ) ;
   for a_row in result {
       final_result.push( a_row.to_vec( ).clone( ) ) ;
   }
   final_result 
}

fn main() -> io::Result<( )> {
    println!("How often should the matrix be shifted ?" ) ;
    let mut inline : String = String::new ( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let shiftnum : u16 = inline.trim( ).parse::<u16>( ).unwrap( ) ;
    println!("Enter a m x n matrix of integers!");
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
    let matrix_lines : Vec<&str> = all_input.trim( ).split("\n").collect( ) ;
    let mut matrix : Vec<Vec<u16>> = Vec::new( ) ;
    matrix_lines.into_iter( ).map( |line| {
            let linenumbers : Vec<u16> = line.split_whitespace( ).map( |s|
                    s.parse::<u16>( ).unwrap( ) ).collect( ) ;
            linenumbers 
            }).for_each( |l| matrix.push( l.clone( ) )) ;
    let mut shifted : Vec<Vec<u16>> = matrix ;
    for _ in 0..shiftnum {
        shifted = shift_once( & shifted ) ;
    }
    println!("{:?}" , shifted ) ;
    Ok(())
}
