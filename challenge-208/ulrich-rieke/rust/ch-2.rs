use std::io ;

fn main() {
    println!("Please enter some integers, with blanks to separate!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut numbers : Vec<i32> = entered_line.split_whitespace( ).
      map( | s | s.trim( ).parse::<i32>( ).expect( "Could not parse!" ))
      .collect( ) ;
    numbers.sort( ) ;
    let mut found : Vec<i32> = Vec::new( ) ;
    let len = numbers.len( ) ;
    for i in 0..len - 1 {
      if numbers[ i ] == numbers[ i + 1 ] { //duplicate , also means missing
      found.push( numbers[ i ] ) ; //duplicate
      if  i == len - 2 { //duplicate here also means missing
        found.push( numbers[ i ] + 1 ) ;
      }
      }
      if numbers[ i + 1 ] - numbers[ i ] > 1 { //missing
      found.push( numbers[ i ] + 1 ) ;
      }
    }
    if found.len( ) > 0 {
      println!("{:?}" , found ) ;
    }
    else {
      println!("-1") ;
    }
}
