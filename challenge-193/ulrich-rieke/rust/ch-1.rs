use std::io ;

fn find_limit( number : usize ) -> i32 {
  let mut sum : i32 = 0 ;
  let mut multiplier : i32 = 1 ;
  for _ in 0..number {
      sum += multiplier ;
      multiplier *= 2 ;
  }
  sum
}

fn to_binary_string( mut num : i32 , length : usize ) -> String {
  let mut binary_str : String = String::new( ) ;
  while num != 0 {
      if num % 2 == 1 {
    binary_str.push( '1' ) ;
      }
      else {
    binary_str.push( '0' ) ;
      }
      num /= 2 ;
  }
  let len : usize = binary_str.len( ) ;
  for _ in len..length {
      binary_str.push( '0' ) ;
  }
  let binary : &str = &binary_str[..] ;
  let mut reversed : String = String::new( ) ;
  binary.chars( ).rev( ).for_each( | c | reversed.push( c ) ) ;
  reversed
}
 
fn main() {
    println!("Enter an integer greater than 0!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered : &str = &*inline ;
    let n : usize = entered.trim( ).parse::<usize>().unwrap( ) ;
    let limit : i32 = find_limit( n ) ;
    let mut strings : Vec<String> = Vec::new( ) ;
    for num in 0..=limit {
      let bin_str = to_binary_string( num , n ) ;
      strings.push( bin_str ) ;
    }
    println!("{:?}" , strings ) ;
}
