use std::io ;

fn find_left_array( numbers : &Vec<i32> ) -> Vec<i32> {
  let len : usize = numbers.len( ) ;
  let limit : usize = len / 2 ;
  let mut left_array : Vec<i32> = Vec::new( ) ;
  left_array.push( 0 ) ;
  let mut left_sum : i32 = 0 ;
  for i in 0..=limit {
      left_sum += numbers[ i ] ;
      left_array.push( left_sum ) ;
  }
  left_array
}

fn find_right_array( numbers : &Vec<i32> ) -> Vec<i32> {
  let len : usize = numbers.len( ) ;
  let left_limit : usize ;
  if len % 2 == 1 {
      left_limit = len / 2 ;
  }
  else {
      left_limit = len / 2 - 1 ;
  }
  let mut right_array : Vec<i32> = Vec::new( ) ;
  let mut right_sum : i32 = 0 ;
  for i in left_limit..len {
      right_sum += numbers[ i ] ;
  }
  right_array.push( right_sum ) ;
  for i in left_limit..len {
      right_sum -= numbers[ i ] ;
      right_array.push( right_sum ) ;
  }
  right_array.push( 0 ) ;
  right_array
}

fn main() {
    println!("Enter some integers , separated by a blank!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
      s.trim( ).parse::<i32>( ).unwrap( )).collect( ) ;
    if numbers.len( ) == 1 {
      println!( "(0)" ) ;
    }
    else {
      let mut result : Vec<i32> = Vec::new( ) ;
      let left_array : Vec<i32> = find_left_array( &numbers ) ;
      let right_array : Vec<i32> = find_right_array( &numbers ) ;
      left_array.iter( ).zip( right_array.iter( )).for_each( | x |
        result.push((x.0 - x.1).abs( ))) ;
      println!("{:?}" , result ) ;
    }
}

