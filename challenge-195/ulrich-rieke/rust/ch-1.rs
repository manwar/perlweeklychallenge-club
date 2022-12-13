use std::io ;
use std::collections::HashMap ;

fn is_special( num : i32 ) -> bool {
  if num < 10 {
      true
  }
  else {
      let mut digit_count = HashMap::new( ) ;
      let mut n = num ;
      while n != 0 {
    let counter = digit_count.entry( n % 10 ).or_insert( 0 ) ;
    *counter += 1 ;
    n /= 10 ;
      }
      let freq_count : Vec<(i32, i32)> = digit_count.into_iter( ).collect( ) ;
      freq_count.iter( ).all( | p | p.1 == 1 )
  }
}

fn main() {
    println!("Please enter an integer greater than 0 !");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let number : i32 = entered_line.trim( ).parse::<i32>( ).unwrap( ) ;
    let mut count : i32 = 0 ;
    for i in 1..=number {
      if is_special( i ) {
      count += 1 ;
      }
    }
    println!("{}" , count ) ;
}
