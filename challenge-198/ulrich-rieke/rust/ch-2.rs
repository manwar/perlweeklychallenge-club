use std::io ;

fn is_prime( number : i32 ) -> bool {
  if number < 2 {
      false
  }
  else {
      let stop : i32 = (number as f32).sqrt( ).floor( ) as i32 ;
      for i in 2..=stop {
    if number % i == 0 {
        return false ;
    }
      }
      true
  }
}

fn main() {
    println!("Enter a positive integer!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let number : i32 = entered_line.trim( ).parse::<i32>( ).unwrap( ) ;
    let mut primcount : i32 = 0 ;
    for i in 0..number {
      if is_prime( i ) {
      primcount += 1 ;
      }
    }
    println!("{}" , primcount ) ;
}
