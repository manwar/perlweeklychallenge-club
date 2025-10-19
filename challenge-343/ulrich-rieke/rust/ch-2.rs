use std::io ;
use std::cmp::Ordering ;

fn main() {
    println!("Please enter some rows with 0 and 1 , all with the same number of digits!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut matrix : Vec<(usize, Vec<u8>)> = Vec::new( ) ;
    let mut rownum : usize = 0 ;
    while inline != "\n".to_string( ) {
       let row : Vec<u8> = inline.trim( ).split_whitespace( ).map( |s| s.parse::<u8>().
	     unwrap( ) ).collect( ) ;
       matrix.push( (rownum , row.clone( ) ) ) ;
       rownum += 1 ;
       println!("Enter more numbers , <enter> to end!") ;
       inline.clear( ) ;
       io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    }
    //order in ascending order by number of 1's in each row
    //if these are equal let the value in the b.0.th column of a.1 decide 
    //if it is 0 then it comes first in ascending order
    matrix.sort_by( |a , b| {
	  let first_ones : usize = a.1.iter( ).filter( |&n| *n == 1 ).count( ) ;
	  let second_ones : usize = b.1.iter( ).filter( |&n| *n == 1 ).count( ) ;
	  if first_ones != second_ones {
	    first_ones.cmp( &second_ones )
	  }
	  else {
	     if a.1.iter( ).nth( b.0 ) == Some(&0) {
	       Ordering::Less 
	     }
	     else {
	        Ordering::Greater
	     }
          }}) ;
    println!("Team {}" , matrix[matrix.len( ) - 1].0) ;
}
