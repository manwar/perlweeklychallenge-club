use std::io ;
use std::cmp::Ordering ;

fn find_valley( numbers : &Vec<i32> , pos : usize ) -> (usize, usize) {
  let mut current_pos : usize = pos ;
  let len = numbers.len( ) ;
  let result : (usize , usize ) ;
  current_pos += 1 ;
  while current_pos < len && numbers[ current_pos ] <=
      numbers[ current_pos - 1 ] {
    current_pos += 1 ;
      }
  if current_pos == len {
      result = (pos , current_pos - 1 - pos) ;
  }
  else {
      current_pos += 1 ;
      while current_pos < len && numbers[ current_pos ] >=
    numbers[ current_pos - 1 ] {
        current_pos += 1 ;
      }
      result = ( pos , current_pos - 1 - pos ) ;
  }
  result
}

fn main() {
    println!("Please enter at least 2 integers, separated by blanks");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( )
      .map( | s | s.trim( ).parse::<i32>( ).expect( "Could not parse number!"))
      .collect( ) ;
    let len = numbers.len( ) ;
    let mut positions : Vec<(usize , usize )> = Vec::new( ) ;
    for i in 0..len - 1 {
      let result = find_valley( &numbers , i ) ;
      positions.push( result ) ;
    }
    let vec_sli : &mut[(usize, usize)] = positions.as_mut_slice( ) ;
    vec_sli.sort_by( | a , b | {
      if b.1.cmp(&a.1) == Ordering::Equal {
        a.0.cmp(&b.0)
      }
      else {
        b.1.cmp( &a.1 )
      }
      }) ;
    let ( startpos , stride ) = vec_sli.first( ).unwrap( ) ;
    let end = *startpos + *stride ;
    for i in *startpos..=end {
      print!("{:?} ," , numbers[ i ] ) ;
    }
    println!( ) ;
}
