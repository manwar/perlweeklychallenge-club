use std::io ;

fn main() {
    println!("Enter some integers, separated by a blank!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line: &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map(
      | s | s.trim( ).parse::<i32>( ).unwrap( )).collect( ) ;
    let mut ordered : Vec<i32> = Vec::new( ) ;
    let mut zerocount = 0 ;
    for i in &numbers {
      if *i != 0 {
      ordered.push( *i ) ;
      }
      else {
      zerocount += 1 ;
      }
    }
    for _ in 0..zerocount {
      ordered.push( 0 ) ;
    }
    println!("{:?}" , ordered ) ;
}
