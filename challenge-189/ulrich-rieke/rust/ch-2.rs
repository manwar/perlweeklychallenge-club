use std::io ;
use std::collections::HashMap ;

fn find_degree( an_array : &Vec<i32> ) -> usize {
  let mut map = HashMap::new( ) ;
  let mut iter = an_array.iter( ) ;
  while let Some( num ) = iter.next( ) {
      let counter = map.entry( num ).or_insert( 0 ) ;
      *counter += 1 ;
  }
  let mut degrees : Vec<i32> = Vec::new( ) ;
  for d in map.values( ) {
      degrees.push( *d ) ;
  }
  *degrees.iter( ).max().unwrap( ) as usize
}


fn main() {
  print!("Please enter an array of non-negative integers, separated by ");
  println!("blanks!") ;
  let mut inputline : String = String::new( ) ;
  io::stdin( ).read_line( &mut inputline ).unwrap( ) ;
  let entered_line : &str = &*inputline ;
  let number_array : Vec<i32> = entered_line.split_whitespace( ).
      map( | s | s.trim( ).parse::<i32>().unwrap( )).collect( ) ;
  let degree = find_degree( &number_array ) ;
  if degree == 1 {
      println!("{}", number_array.iter( ).min( ).unwrap( )) ;
  }
  else {
      let len = number_array.len( ) ;
      let mut subarrays : Vec<Vec<i32>> = Vec::new( ) ;
      for stepwidth in degree..=len {
    for start in 0..=(len - stepwidth) {
        let mut subarray : Vec<i32> = Vec::new( ) ;
        for pos in 0..=(stepwidth - 1) {
          subarray.push( number_array[ start + pos ] ) ;
        }
        if find_degree( &subarray ) == degree {
          subarrays.push( subarray.clone( ) ) ;
        }
    }
      }
      let c_min = | akk: Vec<i32> , ar: Vec<i32> | {
    if akk.iter( ).sum::<i32>( ) < ar.iter( ).sum::<i32>( ) {
        akk
    }
    else {
        ar
    }
      } ;
      let solution : Vec<i32>  = subarrays.into_iter( ).reduce( c_min )
    .unwrap( ).to_vec( ) ;
      println!("{:?}" , solution ) ;
  }
}
