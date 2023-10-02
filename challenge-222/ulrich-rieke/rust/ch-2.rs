use std::io ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ). unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut numbers : Vec<i32> = entered_line.split_whitespace( ).map(
      | s | s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut len : usize = numbers.len( ) ;
    if len == 1 {
      println!("{}" , numbers[0] ) ;
    }
    else {
      numbers.sort( ) ;
      while len > 1 {
      let mut differences : Vec<i32> = Vec::new( ) ;
      for i in 0..len - 1 {
        differences.push( (numbers[ i + 1 ] - numbers[ i ]).abs( ) ) ;
      }
      if differences.iter( ).any( | &n | n != 0 ) {
        let minimum : i32 = *differences.iter( ).filter( | n | **n != 0).
        min( ).unwrap( ) ;
        let pos : usize = differences.iter( ).position( | &n | n ==
          minimum).unwrap( ) ;
        let new = vec![differences[pos]] ;
        numbers.splice( pos..=pos + 1 , new ) ;
      }
      else {
        if len > 1 {
        let new = vec![0] ;
        numbers.splice(0..=1 , new ) ;
        }
      }
      len = numbers.len( ) ;
      }
      println!("{}" , numbers[0] ) ;
    }
}
