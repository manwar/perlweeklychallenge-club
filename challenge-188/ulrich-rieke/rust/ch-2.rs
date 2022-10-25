use std::io ;

fn main() {
    println!("Please enter a positive integer x!" ) ;
    let mut input : String = String::new( ) ;
    io::stdin( ).read_line( &mut input ).unwrap( ) ;
    let mut x : i32 = input.trim( ).parse::<i32>().unwrap( ) ;
    input.clear( ) ;
    println!("Please enter a positive integer y!" ) ;
    io::stdin( ).read_line( &mut input ).unwrap( ) ;
    let mut y : i32 = input.trim( ).parse::<i32>( ).unwrap( ) ;
    if x == y {
      println!("1") ;
    }
    else {
      let mut count : i32 = 1 ;
      while x != y {
      if x > y {
        x = x - y ;
      }
      else {
        y = y - x ;
      }
      count += 1 ;
      }
      println!("{}" , count) ;
    }
}
