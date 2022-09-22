use std::collections::HashSet ;
use std::io ;

#[derive(Eq, Hash, PartialEq)]
struct MyPair {
  first : i32 ,
  second : i32 ,
}

fn main() {
    println!("Please enter an even number of integers separated by a blank!");
    let mut input = String::new( ) ;
    io::stdin().read_line( &mut input).unwrap( ) ;
    let entered_line : &mut str = &mut *input ;
    let numbers : Vec<i32> = entered_line.split( " " )
      .map( |s| s.trim( ).parse::<i32>().unwrap( )).collect( ) ;
    while numbers.len( ) % 2 != 0 {
      println!("For our purposes, enter an even number of integers!") ;
      io::stdin().read_line( &mut input).unwrap( ) ;
      let entered_line : &mut str = &mut *input ;
      let _numbers : Vec<i32> = entered_line.split( " " )
      .map( |s| s.trim( ).parse::<i32>().unwrap( )).collect( ) ;
    }
    let mut all_pairs : Vec<MyPair> = Vec::new( ) ;
    let mut i = 0 ;
    while i < numbers.len( ) {
      let p = MyPair{ first: numbers[i] , second: numbers[ i + 1] } ;
      all_pairs.push( p ) ;
      i += 2 ;
    }
    let mut seen : HashSet<MyPair> = HashSet::new( ) ;
    print!("[ " ) ;
    for pa in all_pairs {
      if ! seen.contains( &pa ) {
      print!("[{},{}] " , pa.first , pa.second) ;
      seen.insert( pa ) ;
      }
    }
    println!("]" ) ;
}
