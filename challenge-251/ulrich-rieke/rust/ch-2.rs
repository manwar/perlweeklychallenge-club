use std::io ;
use std::io::BufRead ;
use std::collections::HashSet ;

fn main() -> io::Result<()> {
    println!("Enter a matrix of m x n integers, <return> to end!");
    let mut lines = io::stdin( ).lock( ).lines( ) ;
    let mut all_input : String = String::new( ) ;
    while let Some( line ) = lines.next( ) {
       let last_input = line.unwrap( ) ;
       if last_input.len( ) == 0 {
	  break ;
       }
       else {
	  all_input.push_str( "\n" ) ;
       }
       all_input.push_str( &last_input ) ;
    }
    let rows : Vec<&str> = all_input.split("\n").collect( ) ;
    let mut matrix : Vec<Vec<i32>> = Vec::new( ) ;
    for r in &rows {
       if r.len( ) > 0 {
	  let rownumbers : Vec<i32> = r.split_whitespace( ).map( | s | 
		s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
	  matrix.push( rownumbers ) ;
       }
    }
    let colnumber : usize = matrix[1].len( ) ;
    let mut all_columns : Vec<Vec<i32>> = Vec::new( ) ;
    for c in 0..colnumber {
       let mut column : Vec<i32> = Vec::new( ) ;
       for r in &matrix {
	  column.push( r[ c ] ) ;
       }
       all_columns.push( column ) ;
    }
    let mut rowminima : HashSet<i32> = HashSet::new( ) ;
    for r in &matrix {
       let rowmin : i32 = *r.iter( ).min( ).unwrap( ) ;
       rowminima.insert( rowmin ) ;
    }
    let mut colmaxima : HashSet<i32> = HashSet::new( ) ;
    for col in &all_columns {
       let colmax : i32 = *col.iter( ).max( ).unwrap( ) ;
       colmaxima.insert( colmax ) ;
    }
    let mut intersection : HashSet<_> = rowminima.intersection( &colmaxima ).
       collect( ) ;
    if intersection.is_empty( ) {
       println!("-1") ;
    }
    else {
       for i in intersection.drain( ) {
	  println!("{}" , i ) ;
       }
    }
    Ok(())
}
